class LivenssResponseModel {
  dynamic externalId;
  bool? passed;
  String? score;

  LivenssResponseModel({this.externalId, this.passed, this.score});

  factory LivenssResponseModel.fromJson(Map<String, dynamic> json) {
    return LivenssResponseModel(
      externalId: json['external_id'] as dynamic,
      passed: json['passed'] as bool?,
      score: json['score'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'external_id': externalId,
        'passed': passed,
        'score': score,
      };
}
