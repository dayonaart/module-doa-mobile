class ActiveCardModelResponse {
  String? cardNum;
  String? channel;
  String? accountNum;
  String? cifNum;
  String? bin;
  String? cardType;
  String? errorCode;
  String? errorMessage;
  String? status;

  ActiveCardModelResponse({
    this.cardNum,
    this.channel,
    this.accountNum,
    this.cifNum,
    this.bin,
    this.cardType,
    this.errorCode,
    this.errorMessage,
    this.status,
  });

  factory ActiveCardModelResponse.fromJson(Map<String, dynamic> json) =>
      ActiveCardModelResponse(
        cardNum: json['cardNum'] as String?,
        channel: json['channel'] as String?,
        accountNum: json['accountNum'] as String?,
        cifNum: json['cifNum'] as String?,
        bin: json['bin'] as String?,
        cardType: json['cardType'] as String?,
        errorCode: json['errorCode'] as String?,
        errorMessage: json['errorMessage'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'cardNum': cardNum,
        'channel': channel,
        'accountNum': accountNum,
        'cifNum': cifNum,
        'bin': bin,
        'cardType': cardType,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'status': status,
      };
}
