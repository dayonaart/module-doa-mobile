class ReceiptEmailModel {
  String? custName;
  String? refNum;
  String? registerDate;
  String? registerTime;
  String? newAccountNum;
  String? accountType;
  String? cardNum;
  String? accountBranch;
  String? branchName;
  String? accStatus;
  String? cardType;
  String? initialDeposit;
  String? lastDepositDate;
  String? channelId;
  String? receipt;
  String? responseCode;
  String? errorCode;

  ReceiptEmailModel({
    this.custName,
    this.refNum,
    this.registerDate,
    this.registerTime,
    this.newAccountNum,
    this.accountType,
    this.cardNum,
    this.accountBranch,
    this.branchName,
    this.accStatus,
    this.cardType,
    this.initialDeposit,
    this.lastDepositDate,
    this.channelId,
    this.receipt,
    this.responseCode,
    this.errorCode,
  });

  ReceiptEmailModel.fromJson(Map<String, dynamic> json) {
    custName = json['custName'];
    refNum = json['refNum'];
    registerDate = json['registerDate'];
    registerTime = json['registerTime'];
    newAccountNum = json['newAccountNum'];
    accountType = json['accountType'];
    cardNum = json['cardNum'];
    accountBranch = json['accountBranch'];
    branchName = json['branchName'];
    accStatus = json['accStatus'];
    cardType = json['cardType'];
    initialDeposit = json['initialDeposit'];
    lastDepositDate = json['lastDepositDate'];
    channelId = json['channelId'];
    receipt = json['receipt'];
    responseCode = json['responseCode'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'custName': custName,
      'refNum': refNum,
      'registerDate': registerDate,
      'registerTime': registerTime,
      'newAccountNum': newAccountNum,
      'accountType': accountType,
      'cardNum': cardNum,
      'accountBranch': accountBranch,
      'branchName': branchName,
      'accStatus': accStatus,
      'cardType': cardType,
      'initialDeposit': initialDeposit,
      'lastDepositDate': lastDepositDate,
      'channelId': channelId,
      'receipt': receipt,
      'responseCode': responseCode,
      'errorCode': errorCode
    };
  }
}
