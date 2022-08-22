import 'soapenv_body.dart';

class SoapenvEnvelope {
  dynamic soapenvHeader;
  SoapenvBody? soapenvBody;

  SoapenvEnvelope({this.soapenvHeader, this.soapenvBody});

  factory SoapenvEnvelope.fromJson(Map<String, dynamic> json) {
    return SoapenvEnvelope(
      soapenvHeader: json['soapenv:Header'] as dynamic,
      soapenvBody: json['soapenv:Body'] == null
          ? null
          : SoapenvBody.fromJson(json['soapenv:Body'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'soapenv:Header': soapenvHeader,
        'soapenv:Body': soapenvBody?.toJson(),
      };
}
