import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
// import 'package:detail/device_detail.dart';
import 'package:device_info/device_info.dart';
// import 'package:device_info/device_info.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/list-error.dart';
import 'package:eform_modul/src/components/popup.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_active_passive_liveness/flutter_active_passive_liveness.dart';
// import 'package:flutter_active_passive_liveness/gesture_type.dart';
// import 'package:flutter_active_passive_liveness/schema_type.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../response_model/device_properties.dart';
import '../../response_model/livenss_response_model.dart';
import '../../service/services.dart';
import '../../src/components/alert-dialog-new-wrap.dart';
import '../../src/components/label-text.dart';
import '../../src/components/url-api.dart';
import '../../src/utility/tensor.dart';
import '../../src/utility/tensor_controller.dart';

class DataFileController extends GetxController {
  late List<CameraDescription> cameras;

  bool isLivenessDone = false;
  bool isKtpDone = false;
  bool isNpwpDone = false;
  bool isSignatureDone = false;
  bool isCaptchaDone = false;

  late SharedPreferences prefs;

  String? errorCode = '';
  String randomString = "";
  String resultLiveness = "";
  TextEditingController captchaController = TextEditingController();
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  CustomLoading customLoading = CustomLoading();

  String? selfiePhoto = "";
  String? idSelfiePhoto = "";
  String? idPhoto = "";
  String? signaturePhoto = "";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  get _bodySavePhotoSelfie async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      'type': 'liveness',
      'nik': prefs.getString('nik'),
      'originalSize': prefs.getString('originalSelfiePhotoSize'),
      'convertSize': prefs.getString('compressedSelfiePhotoSize'),
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress,
      // "refNumber": prefs.getString("refNumber"),
      // "scoreLiveness": prefs.getString('scoreLiveness'),
      'photo': prefs.getString('selfiePhoto'),
    };
  }

  firstLoad() async {
    randomString = getRandomString(5);
    cameras = await availableCameras();
    prefs = Get.find<DataController>().prefs;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    // print(statuses[Permission.location]);

    checkError();
    _requestPermission();

    checkFileDone();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
  }

//CHECK ERROR DENGAN SERVICE BARU
  checkError() {
    if (Get.find<OtpController>().createAccountModelResponse?.errorCode != null) {
      var errorCode = Get.find<OtpController>().createAccountModelResponse?.errorCode;
      // print('Ini Adalah Error Code :' + errorCode.toString());

      var result = ListError().errorMessage(errorCode.toString());

      var errormessage = result;
      errorMessage(errormessage);
      Get.find<OtpController>().createAccountModelResponse?.errorCode = '';
    }
  }

  // checkError() {
  //   if (prefs.getString('errorCode') != "") {
  //     var errorCode = prefs.getString('errorCode') ?? "";

  //     var result = ListError().errorMessage(errorCode);

  //     var errormessage = result;
  //     errorMessage(errormessage);
  //   }
  // }

  Future errorMessage(String errormessage) async {
    return Get.dialog(PopUp(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration:
                const BoxDecoration(color: CustomThemeWidget.orangeButton, shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                'assets/images/tanda_seru.png',
                color: Colors.white,
              ),
            ),
          ),
          seperator(0.025),
          Text(
            'Mohon Maaf',
            style: blackRoboto.copyWith(fontSize: 18),
          ),
          seperator(0.025),
          Text(
            errormessage,
            textAlign: TextAlign.center,
          ),
          seperator(0.05),
          ButtonCostum(
            width: Get.size.width - 120,
            ontap: () {
              Get.back();
            },
            text: 'OK, Saya Mengerti',
          )
        ],
      ),
    ));
  }

  Widget seperator(double height) {
    return SizedBox(
      height: Get.size.height * height,
    );
  }

  checkFileDone() async {
    prefs = Get.find<DataController>().prefs;
    if (prefs.getString("selfiePhoto") != null && prefs.getString("selfiePhoto") != "") {
      isLivenessDone = true;
      selfiePhoto = prefs.getString("selfiePhoto");
    }

    if (prefs.getString("idSelfiePhoto") != null && prefs.getString("idSelfiePhoto") != "") {
      isKtpDone = true;
      idSelfiePhoto = prefs.getString("idSelfiePhoto");
    }

    if (prefs.getString("idPhoto") != null && prefs.getString("idPhoto") != "") {
      isNpwpDone = true;
      idPhoto = prefs.getString("idPhoto");
    }

    if (prefs.getString("signaturePhoto") != null && prefs.getString("signaturePhoto") != "") {
      isSignatureDone = true;
      signaturePhoto = prefs.getString("signaturePhoto");
    }
    update();
  }

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  saveImageSize(
      {required String originalKey,
      required String compressedKey,
      required int originalSize,
      required int compressSize}) {
    prefs = Get.find<DataController>().prefs;
    // print(
    //     "MB SAVE originalSize :${(originalSize / 1024 / 1024).toStringAsFixed(2)}Mb");
    // print(
    //     "MB SAVE compressSize :${(compressSize / 1024 / 1024).toStringAsFixed(2)}Mb");
    prefs.setString(originalKey, "${(originalSize / 1024 / 1024).toStringAsFixed(2)}Mb");
    prefs.setString(compressedKey, "${(compressSize / 1024 / 1024).toStringAsFixed(2)}Mb");
  }

  getCompressImageFromBase64(List<String> value) async {
    print('Ini Adalah Value Compress Image ${value}');

    try {
      List listImage = [];
      var decodedImage;
      for (var a = 0; a < value.length; a++) {
        Uint8List result = base64Decode(value[a]);

        // print(result.length);
        // print(result.lengthInBytes);
        if (value.length > 1) {
          // print("lebih dari 1");
          // print("a $a");
          if (a == 0) {
            // print("masuk 0");
            decodedImage = await decodeImageFromList(result);
            // print("decodedImage.height ${decodedImage.height}");
          }

          listImage.add(
            AspectRatio(
              aspectRatio: decodedImage.width / (decodedImage.height - 15),
              child: new Container(
                margin: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  image: MemoryImage(
                    result,
                  ),
                )),
              ),
            ),
          );
        } else {
          // print("Masuk else");
          listImage.add(
            AspectRatio(
              aspectRatio: 3 / 2,
              child: new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment(0.0, -0.6),
                  image: MemoryImage(
                    result,
                  ),
                )),
              ),
            ),
          );
        }
      }
      return listImage;
    } catch (err) {
      print(err);
    }
  }

  get bodyCekLiveness async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      'respLiveness': resultLiveness,
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  LivenssResponseModel? livenssResponseModel;
  // Future<void> cekLiveness() async {
  //   CustomLoading().showLoading('Memuat Data');
  //   await Future.delayed(Duration(milliseconds: 500));
  //   var body = await bodyCekLiveness;
  //   var result =
  //       await Services().POST(urlcekLiveness, 'Api Cek Liveness', body: body);
  //   print(result?.statusCode);
  //   if (result?.statusCode == 200) {
  //     livenssResponseModel = LivenssResponseModel.fromJson(result?.data?.body);
  //   } else {
  //     ERROR_DIALOG();
  //   }
  // }

  Future<void> startLiveness(BuildContext context, {bool isOnlyLiveness = false}) async {
    // try {
    //   // initialize
    //   var config;
    //   if (Platform.isAndroid) {
    //     config = FlutterActivePassiveParams(
    //       // licenseKey For Development
    //       licenseKey: "78561-F42BE-41D21-5FFF3",
    //       // licenseKey For Production
    //       // licenseKey: "CAD3A-1E119-FDE6F-D9157",
    //       schemaType: SchemaType.schema8,
    //       primaryColor: "#F5D25D",
    //       // APIKey For Development
    //       activeApiKey: "aXRrVMYBGxUKu5ee8fk3kB38VnXQuMBE",
    //       // APIKey For Production
    //       // activeApiKey: "t6tT02eXpz6XgJKhfsGg2fCr7dlYg5h1",

    //       gestureList: [
    //         GestureType.blinkEyes,
    //         GestureType.openMounth,
    //       ],
    //     );
    //   } else if (Platform.isIOS) {
    //     config = FlutterActivePassiveParams(
    //       // licenseKey For Development
    //       licenseKey: "55FA9-1F712-6A53A-BE469",
    //       // licenseKey For Production
    //       // licenseKey: "B5149-4F36E-69BDC-79789",
    //       schemaType: SchemaType.schema8,
    //       primaryColor: "#F5D25D",
    //       // APIKey For Development
    //       activeApiKey: "aXRrVMYBGxUKu5ee8fk3kB38VnXQuMBE",
    //       // APIKey For Production
    //       // activeApiKey: " omHqODTphN7K6662BD7gWgE9rVyOchiA",

    //       gestureList: [
    //         GestureType.blinkEyes,
    //         GestureType.openMounth,
    //       ],
    //     );
    //   }

    //   // mulai liveness detection
    //   ResultData? results = await FluttterActivePassiveLiveness.startLivenessDetection(config);
    //   // prefs.setString('scoreLiveness', results!.data.toString());
    //   // check results tidak sama dengan null
    //   dev.log('Ini Adalah Respon Liveness : ${results?.data}');
    //   dev.log('Ini Adalah Respon Liveness : ${results}');
    //   resultLiveness = results?.data as String;

    //   if (results?.data != null) {
    //     customLoading.showLoading("Memuat data");

    //     Uint8List bytes =
    //         (await FlutterExifRotation.rotateImage(path: results!.image)).readAsBytesSync();

    //     try {
    //       /// compressing....
    //       Uint8List? selfiePhoto = await bytes.compress(maxSize: 1 * 1024 * 1024);

    //       /// save to sharepref...
    //       prefs.setString('selfiePhoto', base64.encode(selfiePhoto!));
    //       await GallerySaver.saveImage(results.image);
    //       // print(
    //       //     "COMPRESS RESULT SELFIE ${(selfiePhoto.lengthInBytes / 1024 / 1024).toStringAsFixed(2)}Mb");

    //       /// saving to gallery
    //       // await ImageGallerySaver.saveImage(selfiePhoto);
    //       // await File('${results.image}').writeAsString(results.image);

    //       await saveImageSize(
    //         originalKey: "originalSelfiePhotoSize",
    //         compressedKey: "compressedSelfiePhotoSize",
    //         originalSize: bytes.lengthInBytes,
    //         compressSize: selfiePhoto.lengthInBytes,
    //       );

    //       // await Future.delayed(Duration(seconds: 1));

    //       //cek Livness
    //       var bodycekLiveness = await bodyCekLiveness;
    //       var resulthasilLiveness =
    //           await Services().POST(urlcekLiveness, 'Api Cek Liveness', body: bodycekLiveness);
    //       print(resulthasilLiveness?.statusCode);

    //       var resulthasilLivenessStatus = resulthasilLiveness?.data?.header['status'];

    //       if (resulthasilLiveness?.statusCode == 200 && resulthasilLivenessStatus == true) {
    //         livenssResponseModel = LivenssResponseModel.fromJson(resulthasilLiveness?.data?.body);
    //         if (!isOnlyLiveness) {
    //           customLoading.dismissLoading();
    //           goSelfieKTPCamera();
    //         } else {
    //           customLoading.dismissLoading();
    //           checkFileDone();
    //         }
    //       } else if (resulthasilLiveness?.statusCode == 400) {
    //         customLoading.dismissLoading();
    //         // goSelfieKTPCamera();
    //         return Get.dialog(PopoutWrapContent(
    //           textTitle: '',
    //           button_radius: 4,
    //           buttonText: 'Ok,saya Mengerti',
    //           ontap: () {
    //             Get.back();
    //             startLiveness(context);
    //           },
    //           content: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Center(
    //                 child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
    //               ),
    //               SizedBox(
    //                 height: 8,
    //               ),
    //               Text(
    //                 'Mohon Maaf',
    //                 style: PopUpTitle,
    //               ),
    //               SizedBox(
    //                 height: 12,
    //               ),
    //               Text(
    //                 "Validasi wajah Anda belum sesuai. Saat melakukan foto selfie pastikan Anda mendapatkan pencahayaan yang jelas dengan menampilkan wajah asli Anda.",
    //                 style: infoStyle,
    //                 textAlign: TextAlign.center,
    //               )
    //             ],
    //           ),
    //         ));
    //       } else {
    //         CustomLoading().dismissLoading();
    //         ERROR_DIALOG();
    //       }
    //       // akhir cek liveness
    //       var body = await _bodySavePhotoSelfie;
    //       var _resSelfie = await Services().POST(urlSavePhoto, 'Api Save Photo', body: body);
    //       if (_resSelfie?.statusCode != 200) {
    //         // print('Masuk Sini');
    //         customLoading.dismissLoading();
    //         return;
    //       }
    //       // dev.log('Ini Body ${_bodySavePhotoSelfie}');
    //       // print("Ini Adalah Status Code Dari Save Photo Selfie" +
    //       //     _resSelfie!.statusCode.toString());
    //       // assert(Global().compareableJwtBody(responseBody: responseBody, jwtBody: jwtBody));
    //       customLoading.dismissLoading();
    //     } catch (e) {
    //       customLoading.dismissLoading();
    //       Get.snackbar("Perhatian", "$e");
    //     }
    //   } else {
    //     // show the dialog
    //     return Get.dialog(PopoutWrapContent(
    //       textTitle: '',
    //       button_radius: 4,
    //       buttonText: 'Ok,saya Mengerti',
    //       ontap: () {
    //         Get.back();
    //         startLiveness(context);
    //       },
    //       content: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Center(
    //             child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
    //           ),
    //           SizedBox(
    //             height: 8,
    //           ),
    //           Text(
    //             'Mohon Maaf',
    //             style: PopUpTitle,
    //           ),
    //           SizedBox(
    //             height: 12,
    //           ),
    //           Text(
    //             "Validasi wajah Anda belum sesuai. Saat melakukan foto selfie pastikan Anda mendapatkan pencahayaan yang jelas dengan menampilkan wajah asli Anda.",
    //             style: infoStyle,
    //             textAlign: TextAlign.center,
    //           )
    //         ],
    //       ),
    //     ));

    //     // startLiveness();
    //   }
    // } catch (e) {
    //   return Get.dialog(PopoutWrapContent(
    //     textTitle: '',
    //     button_radius: 4,
    //     buttonText: 'Ok,saya Mengerti',
    //     ontap: () {
    //       Get.back();
    //       startLiveness(context);
    //     },
    //     content: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Center(
    //           child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
    //         ),
    //         SizedBox(
    //           height: 8,
    //         ),
    //         Text(
    //           'Mohon Maaf',
    //           style: PopUpTitle,
    //         ),
    //         SizedBox(
    //           height: 12,
    //         ),
    //         Text(
    //           "Terjadi Masalah, Silahkan Coba Ambil Foto Lagi. ini Errornya ${e.toString()}",
    //           style: infoStyle,
    //           textAlign: TextAlign.center,
    //         )
    //       ],
    //     ),
    //   ));
    // }
  }

  goSelfieKTPCamera() async {
    if (Platform.isAndroid) {
      var _tensorController = Get.put(TensorController());
      await Get.dialog(TENSOR_CAM(_tensorController), useSafeArea: true);
      checkFileDone();
    } else {
      Get.toNamed(Routes().wajahktp)!.then((val) => val ? checkFileDone() : null);
    }
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
