import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/Global.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jwtson/jwtson.dart';
import 'package:jwtson/jwtson_method_channel.dart';

import '../src/components/alert-dialog-new-wrap.dart';
import '../src/components/label-text.dart';
import '../src/components/list-error.dart';
import '../src/components/theme_const.dart';
import 'package:dio/dio.dart' as dio;

final _jwtsonPlugin = Jwtson();

class Services {
  final DataController _dataController = Get.find();
  BaseOptions _baseDioOption({
    String? url,
  }) {
    return BaseOptions(connectTimeout: 60000, baseUrl: url!);
  }

  Future<ConnectivityResult> checkNetwork() async {
    return await (Connectivity().checkConnectivity());
  }

  String? _unknowError(dynamic error, {Uri? uri}) {
    try {
      return "${error['message']} ${uri ?? ""}";
    } catch (e) {
      return null;
    }
  }

  Future<WrapResponse?> POST(
    String endpoint,
    String step, {
    required dynamic body,
    String? serviceType,
    String? customBaseUrl,
    bool showErrorSnackbar = false,
  }) async {
    var _net = await checkNetwork();

    try {
      final _header = await _dataController.jwtHeaderSoap(step: step);
      final _jwt = await _jwtsonPlugin.generateToken(
          key: Global().generateSecretJwt(timepstamp: _header['timestamp']),
          body: body,
          header: _header);
      if (step == 'Api Save Photo') {
        (body as Map<String, dynamic>).removeWhere((key, value) {
          return key == "photo";
        });
      } else if (step == 'Api Send Otp' || step == 'Api Create Account') {
        (body as Map<String, dynamic>).removeWhere((key, value) {
          return key == "selfiePhoto";
        });
      }
      log(
        jsonEncode({"header": _header, "body": body, "signature": _jwt}),
      );
      var _execute = Dio(_baseDioOption(url: customBaseUrl ?? endpoint)).post(endpoint,
          data: {"header": _header, "body": body, "signature": _jwt},
          options: (serviceType == 'xml')
              ? Options(headers: _dataController.headerSoap(step: step))
              : Options(headers: _dataController.headerJson(step: step)));
      // Execute
      var _res = await _execute;
      return WrapResponse(
          message: _res.statusMessage,
          statusCode: _res.statusCode,
          headers: _res.headers,
          data: await _tryDecodeJwt(_res));
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        showErrorSnackbar
            ? ERROR_SNACK_BAR(
                title: '${e.response?.statusCode}', message: e.response?.statusMessage)
            : null;
        return WrapResponse(
            message: e.response?.statusMessage ?? e.message,
            statusCode: e.response?.statusCode ?? 0,
            data: await _tryDecodeJwt(e.response!),
            headers: e.response?.headers);
      } else if (e.type == DioErrorType.connectTimeout) {
        showErrorSnackbar
            ? ERROR_DIALOG(title: "Perhatian", message: "Koneksi tidak stabil")
            : null;
        return WrapResponse(message: "connection timeout", statusCode: e.response?.statusCode ?? 0);
      } else if (_net == ConnectivityResult.none) {
        ERROR_SNACK_BAR(title: "Perhatian", message: "Pastikan Anda terhubung ke Internet");
        return WrapResponse(message: "connection timeout", statusCode: 000);
      } else {
        ERROR_SNACK_BAR(title: "Perhatian", message: "Terjadi Kesalahan");
        return WrapResponse(message: "connection timeout", statusCode: 999);
      }
    }
  }

  Future<JwtResult?> _tryDecodeJwt(dio.Response<dynamic> _res) async {
    try {
      print(_res.data);
      return await _jwtsonPlugin.decodeJwtToken(
          key: Global().generateSecretJwt(timepstamp: _res.data['header']['timestamp']),
          tokenJwt: _res.data['signature']);
    } catch (e) {
      print("ERROR DECODING JWT because format invalid format");
      return JwtResult(message: "$e");
    }
  }

  Future<WrapResponse?> GET(String endpoint, String step,
      {String? customBaseUrl, bool showErrorSnackbar = false}) async {
    var _net = await checkNetwork();
    try {
      var _execute = Dio(_baseDioOption(url: customBaseUrl ?? endpoint))
          .get(endpoint, options: Options(headers: {"Content-Type": 'application/json'}));
      // Execute
      var _res = await _execute;
      return WrapResponse(
          message: _res.statusMessage, statusCode: _res.statusCode, data: _res.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        showErrorSnackbar
            ? ERROR_DIALOG(
                title: '${e.response?.statusCode}', message: "service sedang maintenance")
            : null;
        return WrapResponse(
            message: e.response?.statusMessage ?? e.message,
            statusCode: e.response?.statusCode ?? 0,
            data: e.response?.data);
      } else if (e.type == DioErrorType.connectTimeout) {
        showErrorSnackbar
            ? ERROR_DIALOG(title: "Perhatian", message: "Koneksi tidak stabil")
            : null;
        return WrapResponse(message: "connection timeout", statusCode: e.response?.statusCode ?? 0);
      } else if (_net == ConnectivityResult.none) {
        ERROR_DIALOG(title: "Perhatian", message: "Pastikan Anda terhubung ke Internet");
        return WrapResponse(message: "connection timeout", statusCode: 000);
      } else {
        ERROR_DIALOG(title: "Perhatian", message: "Terjadi Kesalahan");
        return WrapResponse(message: "connection timeout", statusCode: 999);
      }
    }
  }
}

class WrapResponse {
  String? message;
  int? statusCode;
  JwtResult? data;
  dynamic headers;
  WrapResponse({
    this.message,
    this.statusCode,
    this.data,
    this.headers,
  });
  WrapResponse.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statusCode = json['code'];
    data = JwtResult.fromJson(json['data']);
    headers = json['headers'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status_code'] = statusCode;
    _data['data'] = data?.toJson();
    _data['headers'] = headers;
    return _data;
  }
}

void ERROR_SNACK_BAR({String? title, String? message}) {
  Get.rawSnackbar(
      message: message,
      title: title,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[300]!,
      isDismissible: true,
      duration: const Duration(seconds: 2));
}

void ERROR_DIALOG({String? title, String? message, String? errorCode}) {
  Get.dialog(
    PopoutWrapContent(
        textTitle: '',
        button_radius: 4,
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
            Builder(builder: (context) {
              try {
                return Text(
                  ListError().errorMessage(errorCode!),
                  style: infoStyle,
                  textAlign: TextAlign.center,
                );
              } catch (e) {
                return Text(
                  'Maaf Service Sedang Maintenance',
                  style: infoStyle,
                  textAlign: TextAlign.center,
                );
              }
            })
          ],
        ),
        buttonText: 'Oke Saya Mengerti',
        ontap: () {
          Get.back();
        }),
  );
}

void SUCCESS_DIALOG(String? title, String? message) {
  Get.rawSnackbar(
      message: message,
      title: title,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      isDismissible: true,
      duration: const Duration(seconds: 4));
}
