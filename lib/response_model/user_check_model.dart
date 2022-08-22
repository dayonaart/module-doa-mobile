class UserCheckModel {
  String? channel;
  String? idNum;
  String? idType;
  String? status;
  String? errorCode;
  String? errorMessage;

  UserCheckModel({
    this.channel,
    this.idNum,
    this.idType,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory UserCheckModel.fromJson(Map<String, dynamic> json) {
    return UserCheckModel(
      channel: json['channel'] as String?,
      idNum: json['idNum'] as String?,
      idType: json['idType'] as String?,
      status: json['status'] as String?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'channel': channel,
        'idNum': idNum,
        'idType': idType,
        'status': status,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
}
