import 'package:eform_modul/src/components/Encrypt.dart';

class CreatePinModelResponse {
  String refnum;
  String accountnum;
  String cardnum;
  String pin;
  String? errorCode;
  String? errorMessage;

  CreatePinModelResponse({
    required this.refnum,
    required this.accountnum,
    required this.cardnum,
    required this.pin,
    this.errorCode,
    this.errorMessage,
  });

  factory CreatePinModelResponse.fromJson(Map<String, dynamic> json) => CreatePinModelResponse(
        refnum: json['refnum'] as String,
        accountnum: json['accountNum'] as String,
        cardnum: json['cardNum'] as String,
        pin: json['pin'] as String,
        errorCode: json['errorCode'] as String,
        errorMessage: json['errorMessage'] as String,
      );

  Map<String, dynamic> toJson() => {
        'refNum': refnum,
        'accountNum': accountnum,
        'cardNum': cardnum,
        'pin': pin,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
}
