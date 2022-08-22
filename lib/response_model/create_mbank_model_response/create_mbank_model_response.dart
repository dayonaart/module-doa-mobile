import 'soapenv_envelope.dart';

class CreateMbankModelResponse {
  SoapenvEnvelope? soapenvEnvelope;

  CreateMbankModelResponse({this.soapenvEnvelope});

  factory CreateMbankModelResponse.fromJson(Map<String, dynamic> json) {
    return CreateMbankModelResponse(
      soapenvEnvelope: json['soapenv:Envelope'] == null
          ? null
          : SoapenvEnvelope.fromJson(
              json['soapenv:Envelope'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'soapenv:Envelope': soapenvEnvelope?.toJson(),
      };
}
