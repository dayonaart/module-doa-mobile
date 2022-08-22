import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../BusinessLogic/Registrasi/DataFileController.dart';
import '../../../components/label-text.dart';
import '../../../components/leading.dart';
import '../../../components/theme_const.dart';
import '../../../utility/custom_loading.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';

class TandaTanganPage extends StatefulWidget {
  @override
  _TandaTanganPageState createState() => _TandaTanganPageState();
}

class _TandaTanganPageState extends State<TandaTanganPage> {
  // late List<CameraDescription> cameras;

  CameraController? cameraController;
  XFile? imageFile;
  XFile? videoFile;
  VoidCallback? videoPlayerListener;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _flashModeControlRowAnimationController;
  late AnimationController _exposureModeControlRowAnimationController;
  late AnimationController _focusModeControlRowAnimationController;
  final cameras = Get.find<DataFileController>().cameras;
  late SharedPreferences prefs;

  bool isTakeFoto = false;
  String imagePath = "";

  CustomLoading customLoading = CustomLoading();

  DataFileController dataFileController = Get.put(DataFileController());

  @override
  void initState() {
    super.initState();
    dataFileController.firstLoad();
    initCameraController(cameras.first);
  }

  initCameraController(CameraDescription description) async {
    cameraController = CameraController(description, ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.setFlashMode(FlashMode.off);
      });
    });

    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    if (cameraController != null) {
      cameraController!.dispose();
      cameraController = null;
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
    String code = "";
    for (var i = 0; i < 6; i++) {
      code = code + Random().nextInt(9).toString();
    }
    return Scaffold(
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
          "Foto Tanda Tangan",
          style: appBarText,
        ),
      ),
      body: !isTakeFoto
          ? Stack(
              children: [
                if (cameraController != null)
                  cameraController!.value.isInitialized
                      // ? Container(
                      //     height: MediaQuery.of(context).size.height,
                      //     child: CameraPreview(cameraController),
                      //   )
                      ? Transform.scale(
                          scale: 1 /
                              (cameraController!.value.aspectRatio *
                                  MediaQuery.of(context).size.aspectRatio),
                          alignment: Alignment.topCenter,
                          child: CameraPreview(cameraController!),
                        )
                      : Container(),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.srcOut,
                  ),
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
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width - 145,
                                width: MediaQuery.of(context).size.width - 35,
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
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6),
                  child: Center(
                    child: Column(
                      // mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: <double>[5, 5],
                          color: Colors.white,
                          radius: Radius.circular(12.0),
                          padding: EdgeInsets.zero,
                          strokeWidth: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.width - 145,
                            width: MediaQuery.of(context).size.width - 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Stack(children: [
              Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buttonNavigasi(),
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
                firstText:
                    "Buat tanda tangan Anda pada kertas putih. Pastikan ",
                boldText: "posisi tanda tangan Anda pada area yang tersedia ",
                endText:
                    "dan klik ambil foto. Pastikan foto terlihat dengan jelas.",
                buttonText: "Ambil Foto",
                ontap: onTakePictureButtonPressed,
              ).show()

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.

                  ),
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
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<XFile?> takePicture() async {
    if (!cameraController!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController!.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    try {
      takePicture().then((XFile? file) async {
        if (mounted) {
          setState(() {
            imageFile = file;
          });
          if (file != null) {
            // showInSnackBar('Picture saved to ${file.path}');
            setState(() {
              // prefs.setString('ktp_npwp_path', file.path);
              imagePath = file.path;
              isTakeFoto = true;
            });
            // Navigator.pop(context,true);
            customLoading.showLoading("Memuat data");
            try {
              var bytes = File(imagePath).readAsBytesSync();
              Uint8List? signaturePhoto =
                  await bytes.compress(maxSize: 1 * 1024 * 1024);
              // await ImageGallerySaver.saveImage(signaturePhoto!);
              await GallerySaver.saveImage(imagePath);

              print(
                  "COMPRESS RESULT SIGNATURE ${(signaturePhoto!.lengthInBytes / 1024 / 1024).toStringAsFixed(2)}Mb");
              dataFileController.saveImageSize(
                originalKey: "originalSignaturePhotoSize",
                compressedKey: "compressedSignaturePhotoSize",
                originalSize: bytes.lengthInBytes,
                compressSize: signaturePhoto.lengthInBytes,
              );
              customLoading.dismissLoading();
              setState(() {
                prefs.setString(
                    'signaturePhoto', base64.encode(signaturePhoto));
              });
            } catch (e) {
              customLoading.dismissLoading();
              Get.snackbar("Perhatian", "$e");
            }
            Navigator.pop(context, true);
          }
        }
      });
    } catch (err) {
      print("err $err");
    }
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
