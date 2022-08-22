import 'detail.dart';

class SoapenvFault {
  String? faultcode;
  String? faultstring;
  Detail? detail;

  SoapenvFault({this.faultcode, this.faultstring, this.detail});

  factory SoapenvFault.fromJson(Map<String, dynamic> json) => SoapenvFault(
        faultcode: json['faultcode'] as String?,
        faultstring: json['faultstring'] as String?,
        detail: json['detail'] == null
            ? null
            : Detail.fromJson(json['detail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'faultcode': faultcode,
        'faultstring': faultstring,
        'detail': detail?.toJson(),
      };
}
