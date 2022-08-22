import 'package:equatable/equatable.dart';

class SendOtpModel extends Equatable {
  final String refNum;
  final String channel;
  final String cifNum;
  final String accountNum;
  final String customerName;
  final String idNum;
  final String idType;
  final String status;
  final String errorCode;
  final String errorMessage;

  SendOtpModel(
      {this.refNum = '',
      this.channel = 'EFORM',
      this.cifNum = '',
      this.accountNum = '',
      this.customerName = '',
      this.idNum = '',
      this.idType = '',
      this.status = '',
      this.errorCode = '',
      this.errorMessage = ''});

  factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(
        refNum: json['refNum'],
        channel: json['channel'],
        cifNum: json['cifNum'],
        accountNum: json['accountNum'],
        customerName: json['customerName'],
        idNum: json['idNum'],
        idType: json['idType'],
        status: json['status'],
        errorCode: json['errorCode'],
        errorMessage: json['errorMessage']);
  }

  @override
  List<Object?> get props => [
        refNum,
        channel,
        cifNum,
        accountNum,
        customerName,
        idNum,
        idType,
        status,
        errorCode,
        errorMessage
      ];
}
