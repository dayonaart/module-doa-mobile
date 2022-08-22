class NeInquiryAllParamFault1AppFault {
  String? errorNum;
  String? errorDescription;

  NeInquiryAllParamFault1AppFault({this.errorNum, this.errorDescription});

  factory NeInquiryAllParamFault1AppFault.fromJson(Map<String, dynamic> json) {
    return NeInquiryAllParamFault1AppFault(
      errorNum: json['errorNum'] as String?,
      errorDescription: json['errorDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'errorNum': errorNum,
        'errorDescription': errorDescription,
      };
}
