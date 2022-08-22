class UpdateCardModelResponse {
  String? cardNum;
  String? channel;
  String? accountNum;
  String? cifNum;
  String? bin;
  String? cardType;
  String? oldStatus;
  String? newStatus;
  String? errorCode;
  String? errorMessage;
  String? operationStatus;

  UpdateCardModelResponse({
    this.cardNum,
    this.channel,
    this.accountNum,
    this.cifNum,
    this.bin,
    this.cardType,
    this.oldStatus,
    this.newStatus,
    this.errorCode,
    this.errorMessage,
    this.operationStatus,
  });

  factory UpdateCardModelResponse.fromJson(Map<String, dynamic> json) =>
      UpdateCardModelResponse(
        cardNum: json['cardNum'] as String?,
        channel: json['channel'] as String?,
        accountNum: json['accountNum'] as String?,
        cifNum: json['cifNum'] as String?,
        bin: json['bin'] as String?,
        cardType: json['cardType'] as String?,
        oldStatus: json['oldStatus'] as String?,
        newStatus: json['newStatus'] as String?,
        errorCode: json['errorCode'] as String?,
        errorMessage: json['errorMessage'] as String?,
        operationStatus: json['operationStatus'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'cardNum': cardNum,
        'channel': channel,
        'accountNum': accountNum,
        'cifNum': cifNum,
        'bin': bin,
        'cardType': cardType,
        'oldStatus': oldStatus,
        'newStatus': newStatus,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'operationStatus': operationStatus,
      };
}
