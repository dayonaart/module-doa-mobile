class SendOtpModelResponse {
  String? refNum;
  String? channel;
  String? cifNum;
  String? accountNum;
  String? customerName;
  String? idNum;
  String? idType;
  String? status;
  String? errorCode;
  String? errorMessage;

  SendOtpModelResponse({
    this.refNum,
    this.channel,
    this.cifNum,
    this.accountNum,
    this.customerName,
    this.idNum,
    this.idType,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory SendOtpModelResponse.fromJson(Map<String, dynamic> json) =>
      SendOtpModelResponse(
        refNum: json['refNum'] as String?,
        channel: json['channel'] as String?,
        cifNum: json['cifNum'] as String?,
        accountNum: json['accountNum'] as String?,
        customerName: json['customerName'] as String?,
        idNum: json['idNum'] as String?,
        idType: json['idType'] as String?,
        status: json['status'] as String?,
        errorCode: json['errorCode'] as String?,
        errorMessage: json['errorMessage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'refNum': refNum,
        'channel': channel,
        'cifNum': cifNum,
        'accountNum': accountNum,
        'customerName': customerName,
        'idNum': idNum,
        'idType': idType,
        'status': status,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
}
