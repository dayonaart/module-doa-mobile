class CreateAccountModelResponse {
  String? refNum;
  String? channel;
  String? cifNum;
  String? accountNum;
  String? customerName;
  String? idNum;
  String? idType;
  String? status;
  String? errorCode;
  String? newAccountNum;
  String? errorMessage;

  CreateAccountModelResponse(
      {this.refNum = '',
      this.channel = 'EFORM',
      this.cifNum = '',
      this.accountNum = '',
      this.customerName = '',
      this.idNum = '',
      this.idType = '',
      this.status = '',
      this.errorCode = '',
      this.errorMessage = '',
      this.newAccountNum = ''});

  factory CreateAccountModelResponse.fromJson(Map<String, dynamic> json) {
    return CreateAccountModelResponse(
      refNum: json['refNum'],
      channel: json['channel'],
      cifNum: json['cifNum'],
      accountNum: json['accountNum'],
      newAccountNum: json['newAccountNum'],
      customerName: json['customerName'],
      idNum: json['idNum'],
      idType: json['idType'],
      status: json['status'],
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() => {
        'refnum': refNum,
        'channel': channel,
        'cifnum': cifNum,
        'accountNum': accountNum,
        'newAccountNum': newAccountNum,
        'customerName': customerName,
        'idNum': idNum,
        'idType': idType,
        'status': status,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
}
