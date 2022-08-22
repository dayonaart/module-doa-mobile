class GetCardModelResponse {
  String? channel;
  String? accountNum;
  String? cifNum;
  String? bin;
  String? cardType;
  String? cardNum;
  String? errorCode;
  String? errorMessage;
  String? status;

  GetCardModelResponse({
    this.channel,
    this.accountNum,
    this.cifNum,
    this.bin,
    this.cardType,
    this.cardNum,
    this.errorCode,
    this.errorMessage,
    this.status,
  });

  factory GetCardModelResponse.fromJson(Map<String, dynamic> json) =>
      GetCardModelResponse(
        channel: json['channel'] as String?,
        accountNum: json['accountNum'] as String?,
        cifNum: json['cifNum'] as String?,
        bin: json['bin'] as String?,
        cardType: json['cardType'] as String?,
        cardNum: json['cardNum'] as String?,
        errorCode: json['errorCode'] as String?,
        errorMessage: json['errorMessage'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'channel': channel,
        'accountNum': accountNum,
        'cifNum': cifNum,
        'bin': bin,
        'cardType': cardType,
        'cardNum': cardNum,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'status': status,
      };
}
