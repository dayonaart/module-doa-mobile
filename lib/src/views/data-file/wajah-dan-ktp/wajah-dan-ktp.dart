import 'dart:convert';
import 'dart:io';
// import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import '../../../../BusinessLogic/Registrasi/DataFileController.dart';
import '../../../components/alert-dialog-new-wrap.dart';
import '../../../components/alert-dialog-new.dart';
// import 'package:image/image.dart' as imageLib;

import '../../../components/label-text.dart';
import '../../../components/leading.dart';
import '../../../components/theme_const.dart';
import '../../../utility/custom_loading.dart';
// import 'tensor-flow/box_widget.dart';
// import 'tensor-flow/camera_view_singleton.dart';
// import 'tensor-flow/classifier.dart';
// import 'tensor-flow/isolate_utils.dart';
import 'tensor-flow/recognition.dart';
import 'tensor-flow/stats.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';

class WajahDanKtpPage extends StatefulWidget {
  @override
  _WajahDanKtpPageState createState() => _WajahDanKtpPageState();
}

class _WajahDanKtpPageState extends State<WajahDanKtpPage>
    with WidgetsBindingObserver {
  CameraController? cameraController;
  XFile? imageFile;
  XFile? videoFile;
  VoidCallback? videoPlayerListener;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _flashModeControlRowAnimationController;
  late AnimationController _exposureModeControlRowAnimationController;
  late AnimationController _focusModeControlRowAnimationController;

  late SharedPreferences prefs;

  bool isTakeFoto = false;
  String imagePath = "";

  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  Stats? stats;

  /// List of available cameras
  final cameras = Get.find<DataFileController>().cameras;

  /// true when inference is ongoing
  bool predicting = false;

  /// Instance of [Classifier]
  // Classifier? classifier;

  /// Instance of [IsolateUtils]
  // IsolateUtils? isolateUtils;

  late final size;
  late final deviceRatio;
  late final xScale;
  // Modify the yScale if you are in Landscape
  final yScale = 1.0;
  CustomLoading customLoading = CustomLoading();

  DataFileController dataFileController = Get.put(DataFileController());

  @override
  void initState() {
    super.initState();

    dataFileController.firstLoad();
    // size = MediaQuery.of(context).size;
    // deviceRatio = size.width / size.height;
    // xScale = cameraController.value.aspectRatio / deviceRatio;

    initCameraController(cameras.last);
    // initStateAsync();
  }

  // void initStateAsync() async {
  //  size = MediaQuery.of(context).size;
  //  deviceRatio = size.width / size.height;
  //  xScale = cameraController.value.aspectRatio / deviceRatio;

  //   WidgetsBinding.instance?.addObserver(this);

  //   // Spawn a new isolate
  //   isolateUtils = IsolateUtils();
  //   await isolateUtils?.start();

  //   // Camera initialization
  //   initCameraController(cameras.last);

  //   // Create an instance of classifier to load model and labels
  //   classifier = Classifier();

  //   // Initially predicting = false
  //   predicting = false;
  // }

  initCameraController(CameraDescription description) async {
    cameraController = CameraController(description, ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        // isCameraReady = true;
        cameraController!.setFlashMode(FlashMode.off);
      });
    });

    prefs = await SharedPreferences.getInstance();

    // cameraController?.initialize().then((_) async {
    //   // Stream of image passed to [onLatestImageAvailable] callback
    //   if (!cameraController!.value.isStreamingImages) {
    //     await cameraController?.startImageStream(onLatestImageAvailable);
    //   }

    //   /// previewSize is size of each image frame captured by controller
    //   ///
    //   /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
    //   Size? previewSize = cameraController?.value.previewSize;

    //   /// previewSize is size of raw input image to the model
    //   CameraViewSingleton.inputImageSize = previewSize;

    //   // the display width of image on screen is
    //   // same as screenWidth while maintaining the aspectRatio
    //   Size screenSize = MediaQuery.of(context).size;
    //   CameraViewSingleton.screenSize = screenSize;
    //   CameraViewSingleton.ratio = screenSize.width / previewSize!.height;

    //   cameraController?.setFlashMode(FlashMode.off);
    // });
  }

  @override
  void dispose() {
    if (cameraController != null) {
      cameraController = null;
      cameraController!.dispose();
    }
    // WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _changeCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = cameraController!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      initCameraController(newDescription);
    } else {
      print('Asked camera not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    // if (cameraController == null || !cameraController.value.isInitialized) {
    //   return Container();
    // }
    String code = "";
    for (var i = 0; i < 6; i++) {
      code = code + Random().nextInt(9).toString();
    }
    return Stack(
      children: [
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: LeadingIcon(
                context: context,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 1,
              backgroundColor: const Color(0xFFEDF1F3),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              title: Text(
                "Foto Wajah & KTP",
                style: appBarText,
              ),
            ),
            body: !isTakeFoto
                ? Stack(
                    children: [
                      if (cameraController != null)
                        cameraController!.value.isInitialized
                            ?
                            // Container(
                            //   height: MediaQuery.of(context).size.height,
                            //   child: CameraPreview(cameraController),
                            // )
                            Transform.scale(
                                scale: 4 / 3,
                                // 1 /
                                //     (cameraController!.value.aspectRatio *
                                //         MediaQuery.of(context).size.aspectRatio),
                                alignment: Alignment.topCenter,
                                child: CameraPreview(
                                  cameraController!,
                                ),
                              )
                            : Container(),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6),
                          BlendMode.srcOut,
                        ), // This one will create the magic
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                backgroundBlendMode: BlendMode.dstOut,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: Center(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 230,
                                      height: 290,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: new BorderRadius.all(
                                          Radius.elliptical(230, 290),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width -
                                              210,
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: InkWell(
                          onTap: _changeCameraLens,
                          child: Image.asset(
                            "assets/images/simpanan-icon-change-camera.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: <double>[5, 5],
                                color: Colors.white,
                                radius: Radius.elliptical(230, 290),
                                padding: EdgeInsets.zero,
                                strokeWidth: 2,
                                child: Container(
                                  width: 230,
                                  height: 290,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: <double>[5, 5],
                                color: Colors.white,
                                radius: Radius.circular(12.0),
                                padding: EdgeInsets.zero,
                                strokeWidth: 2,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width - 210,
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: buttonNavigasi(),
          ),
        ),
        if (isTakeFoto)
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
                ontap: () async {
                  try {
                    customLoading.showLoading("Memuat data");

                    var bytes = File(imagePath).readAsBytesSync();
                    Uint8List? idSelfiePhoto =
                        await bytes.compress(maxSize: 1 * 1024 * 1024);
                    await GallerySaver.saveImage(imagePath);
                    // await ImageGallerySaver.saveImage(idSelfiePhoto!);
                    print(
                        "COMPRESS RESULT ID SELFIE ${(idSelfiePhoto!.lengthInBytes / 1024 / 1024).toStringAsFixed(2)}Mb");

                    customLoading.dismissLoading();
                    setState(() {
                      prefs.setString(
                          'idSelfiePhoto', base64.encode(idSelfiePhoto));
                    });
                  } catch (err) {
                    customLoading.dismissLoading();
                    Get.snackbar("Perhatian", "$e");
                  }
                  Navigator.pop(context, true);
                }),
          ),
      ],
    );
  }

  getDottedBorder({
    required String text,
    required bool isRequired,
  }) {
    return DottedBorder(
      borderType: BorderType.RRect,
      padding: EdgeInsets.symmetric(
        horizontal: 110,
        vertical: 60,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            isRequired ? "(Wajib)" : "(Bila Ada)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  buttonNavigasi() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: StackDialog(
                context: context,
                firstText: "Pastikan ",
                boldText: "wajah Anda memenuhi area ",
                endText: "dan ambil foto ketika Anda siap.",
                buttonText: "Ambil Foto",
                ontap: onTakePictureButtonPressed,
              ).show()),
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    cameraController = null;
    cameraController?.dispose();
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<XFile?> takePicturex() async {
    if (!cameraController!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile? file = await cameraController?.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    // cameraController!.stopImageStream();
    takePicturex().then((XFile? file) async {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
          // showInSnackBar('Picture saved to ${file.path}');
          setState(() {
            imagePath = file.path;
            isTakeFoto = true;
          });
          // Navigator.pop(context,true);

          customLoading.showLoading("Memuat data");
          try {
            var bytes = File(imagePath).readAsBytesSync();

            // Uint8List idSelfiePhoto = await getComporessList(bytes);
            // await ImageGallerySaver.saveImage(idSelfiePhoto);

            /// compressing....
            Uint8List? idSelfiePhoto =
                await bytes.compress(maxSize: 1 * 1024 * 1024);

            /// saving to gallery
            await GallerySaver.saveImage(imagePath);
            // await ImageGallerySaver.saveImage(idSelfiePhoto!);

            dataFileController.saveImageSize(
              originalKey: "originalIdSelfiePhotoSize",
              compressedKey: "compressedIdSelfiePhotoSize",
              originalSize: bytes.lengthInBytes,
              compressSize: idSelfiePhoto!.lengthInBytes,
            );

            customLoading.dismissLoading();
            setState(() {
              prefs.setString('idSelfiePhoto', base64.encode(idSelfiePhoto));
            });
          } catch (e) {
            customLoading.dismissLoading();
            Get.snackbar("Perhatian", "$e");
          }
        }
      }
    });
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _exposureModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }
}
