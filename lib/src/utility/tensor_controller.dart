import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';

import '../components/alert-dialog-new-wrap.dart';
import '../components/alert-dialog-new.dart';
import '../components/label-text.dart';
import '../components/theme_const.dart';

class TensorController extends GetxController with WidgetsBindingObserver {
  FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? customPaint;
  late List<CameraDescription> camera;
  CameraController? camController;
  XFile? imageFile;
  double minAvailableExposureOffset = 0.0;
  double maxAvailableExposureOffset = 0.0;
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  int pointers = 0;
  double _currentScale = 1.0;
  double baseScale = 1.0;
  bool showCamera = false;
  Future<void> initCamera() async {
    camera = await availableCameras();
    var _frontCam = camera.where((e) => e.lensDirection == CameraLensDirection.front).first;
    camController = CameraController(_frontCam, ResolutionPreset.max);
    try {
      await camController?.initialize();
      await camController!.setFlashMode(FlashMode.off);
      showCamera = true;
      update();
    } catch (e) {
      Get.snackbar("Attention!", "$e", snackPosition: SnackPosition.BOTTOM);
      showCamera = false;
      update();
    }
  }

  void closeCam() {
    showCamera = false;
    update();
  }

  Future<void> onNewCameraSelected() async {
    final CameraController? oldController = camController;
    if (oldController != null) {
      camController = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      camController!.description,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    camController = cameraController;
    cameraController.addListener(() {
      if (cameraController.value.hasError) {
        Get.snackbar("Attention!", "Camera error ${cameraController.value.errorDescription}",
            snackPosition: SnackPosition.BOTTOM);
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        ...<Future<Object?>>[
          cameraController
              .getMinExposureOffset()
              .then((double value) => minAvailableExposureOffset = value),
          cameraController
              .getMaxExposureOffset()
              .then((double value) => maxAvailableExposureOffset = value)
        ],
        cameraController.getMaxZoomLevel().then((double value) => maxAvailableZoom = value),
        cameraController.getMinZoomLevel().then((double value) => minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          Get.snackbar("Attention!", 'You have denied camera access.',
              snackPosition: SnackPosition.BOTTOM);
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          Get.snackbar("Attention!", 'Please go to Settings app to enable camera access.',
              snackPosition: SnackPosition.BOTTOM);
          break;
        case 'CameraAccessRestricted':
          // iOS only
          Get.snackbar("Attention!", 'Camera access is restricted.',
              snackPosition: SnackPosition.BOTTOM);
          break;
        case 'cameraPermission':
          // Android & web only
          Get.snackbar("Attention!", 'Unknown permission error.',
              snackPosition: SnackPosition.BOTTOM);
          break;
        default:
          // _showCameraException(e);
          break;
      }
    }
  }

  void handleScaleStart(ScaleStartDetails details) {
    baseScale = _currentScale;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (camController == null || pointers != 2) {
      return;
    }

    _currentScale = (baseScale * details.scale).clamp(minAvailableZoom, maxAvailableZoom);

    await camController!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (camController == null) {
      return;
    }
  }

  Future<void> onTakePictureButtonPressed() async {
    var _file = await takePicture();
    if (_file != null) {
      var _foundFace = await _faceDetect(InputImage.fromFile(File(_file.path)));
      if (_foundFace) {
        _faceDetector.close();

        try {
          CustomLoading().showLoading('Memuat Data');
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          var _imageBytes = File(_file.path).readAsBytesSync();
          Uint8List? idSelfiePhoto = await _imageBytes.compress(maxSize: 1 * 1024 * 1024);
          // await ImageGallerySaver.saveImage(idSelfiePhoto!);
          await GallerySaver.saveImage(_file.path);
          await _prefs.setString('idSelfiePhoto', base64.encode(idSelfiePhoto!));
          // Get.back(result: File(_file.path));
          CustomLoading().dismissLoading();
          await _finishOnTakePicture(true);
        } catch (e) {
          CustomLoading().dismissLoading();
          Get.back();
        }
      } else {
        _finishOnTakePicture(false);
        // Get.snackbar("Perhatian!", "Pastikan wajah terlihat jelas",
        //     backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = camController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      Get.snackbar("Attention!", 'Error: select a camera first.',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      return null;
    }
  }

  Future<bool> _faceDetect(InputImage inputImage) async {
    if (!_canProcess) return false;
    if (_isBusy) return false;
    _isBusy = true;
    final faces = await _faceDetector.processImage(inputImage);
    var _foundface = faces.map((e) => !e.boundingBox.hasNaN);
    _isBusy = false;
    return _foundface.contains(true);
  }

  Future<void> _finishOnTakePicture(bool succeded) async {
    succeded
        ? await Get.dialog(
            Container(
              color: Color(0xFF5E5E5E).withOpacity(0.75),
              child: Popout(
                  textTitle: '',
                  // height: 180,
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Tahapan pengambilan '),
                        TextSpan(
                            text: 'foto wajah & KTP',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' selesai dilakukan'),
                      ],
                    ),
                  ),
                  buttonText: 'Selanjutnya',
                  ontap: () {
                    // Get.toNamed(Routes().datafile);
                    Get.back();
                    Get.back();
                  }),
            ),
          )
        : await Get.dialog(
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopoutWrapContent(
                    textTitle: '',
                    button_radius: 4,
                    buttonText: 'Ok,saya Mengerti',
                    ontap: () {
                      Get.back();
                    },
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Mohon Maaf',
                          style: PopUpTitle,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Validasi wajah Anda belum sesuai. Mohon ulangi proses pengambilan foto selfie dengan menampilkan wajah Anda",
                          style: infoStyle,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )

                  // ElevatedButton(
                  //     style: ButtonStyle(
                  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //             RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(15.0),
                  //                 side:
                  //                     BorderSide(color: Colors.white, width: 0.5))),
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.white)),
                  //     onPressed: () {
                  //       Get.back();
                  //     },
                  //     child: _finishText(succeded)),
                ],
              ),
            ),
            barrierColor: Colors.black87);
  }

  RichText _finishText(bool succeded) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: succeded ? Colors.black : Colors.red,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Tahapan pengambilan '),
          TextSpan(text: 'foto wajah & KTP', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' selesai dilakukan${succeded ? "" : "\npastikan wajah terlihat jelas"}'),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      if (camController == null || !camController!.value.isInitialized) {
        return;
      }
      switch (state) {
        case AppLifecycleState.resumed:
          print('Resumed');
          onNewCameraSelected();
          break;
        case AppLifecycleState.inactive:
          camController?.dispose();
          print('Inactive');
          break;
        case AppLifecycleState.paused:
          print('Paused');
          break;
        case AppLifecycleState.detached:
          print('Detached');
          break;
      }
    } catch (e) {
      // Get.snackbar("Attention!", "$e");
    }
  }
}
