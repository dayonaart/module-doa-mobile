import 'package:equatable/equatable.dart';

class CardandPinModel extends Equatable {
  final String channel;
  final String accountNum;
  final String cifNum;
  final String bin;
  final String cardType;
  final String cardNum;
  final String errorCode;
  final String errorMessage;

  CardandPinModel({
    this.channel = 'EFORM',
    required this.accountNum,
    required this.cifNum,
    required this.bin,
    required this.cardType,
    required this.cardNum,
    this.errorCode = '',
    this.errorMessage = '',
  });

  factory CardandPinModel.fromJson(Map<String, dynamic> json) {
    return CardandPinModel(
      channel: json['channel'],
      accountNum: json['accountNum'],
      cifNum: json['cifNum'],
      bin: json['bin'],
      cardType: json['cardType'],
      cardNum: json['cardNum'],
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        channel,
        accountNum,
        bin,
        cardType,
        cardNum,
        errorCode,
        errorMessage,
        cifNum
      ];
}
