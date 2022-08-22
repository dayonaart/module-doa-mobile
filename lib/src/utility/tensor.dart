import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/utility/tensor_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TENSOR_CAM(TensorController _tensorController) {
  return GetBuilder<TensorController>(initState: (st) async {
    await _tensorController.initCamera();
  }, builder: (_) {
    return Builder(builder: (context) {
      if (_.camController != null) {
        return Scaffold(body: _cameraPreviewWidget(context, _tensorController));
      }
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 20),
            SizedBox(height: 20),
            Text("Please Wait...")
          ],
        ),
      );
    });
  });
}

Widget _cameraPreviewWidget(BuildContext context, TensorController _controller) {
  return Column(
    children: [
      Expanded(
        child: CameraPreview(_controller.camController!,
            child: Container(
              width: Get.width,
              child: Column(children: [
                // Expanded(
                //     child: _ktpFacePreview(context,
                //         radius: Radius.elliptical(230, 290), width: (Get.width / 1.2))),
                // SizedBox(height: 20),
                // _ktpFacePreview(context, heigth: Get.height / 4),
                SizedBox(
                  height: 20,
                ),
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
                    height: MediaQuery.of(context).size.width - 210,
                    width: MediaQuery.of(context).size.width - 120,
                  ),
                ),

                Expanded(
                  child: StackDialog(
                    btnbottompadding: 20,
                    context: context,
                    firstText: "Pastikan ",
                    boldText: "posisi e-KTP asli pada area yang tersedia ",
                    endText: "dan klik ambil foto. Pastikan foto terlihat dengan jelas.",
                    buttonText: "Ambil Foto",
                    ontap: () async => await _controller.onTakePictureButtonPressed(),
                  ).show(),
                ),
              ]),
            )),
      ),
    ],
  );
}

Padding _ktpFacePreview(BuildContext context, {double? heigth, double? width, Radius? radius}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: <double>[5, 5],
      color: Colors.white,
      radius: radius ?? Radius.circular(12.0),
      padding: EdgeInsets.zero,
      strokeWidth: 2,
      child: Container(
        height: heigth,
        width: width,
      ),
    ),
  );
}
