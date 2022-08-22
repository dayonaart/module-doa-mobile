import 'soapenv_fault.dart';

class SoapenvBody {
  SoapenvFault? soapenvFault;

  SoapenvBody({this.soapenvFault});

  factory SoapenvBody.fromJson(Map<String, dynamic> json) => SoapenvBody(
        soapenvFault: json['soapenv:Fault'] == null
            ? null
            : SoapenvFault.fromJson(
                json['soapenv:Fault'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'soapenv:Fault': soapenvFault?.toJson(),
      };
}
