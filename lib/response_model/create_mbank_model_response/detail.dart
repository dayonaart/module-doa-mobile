import 'ne_inquiry_all_param_fault1_app_fault.dart';

class Detail {
  NeInquiryAllParamFault1AppFault? neInquiryAllParamFault1AppFault;

  Detail({this.neInquiryAllParamFault1AppFault});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        neInquiryAllParamFault1AppFault:
            json['ne:inquiryAllParamFault1_appFault'] == null
                ? null
                : NeInquiryAllParamFault1AppFault.fromJson(
                    json['ne:inquiryAllParamFault1_appFault']
                        as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'ne:inquiryAllParamFault1_appFault':
            neInquiryAllParamFault1AppFault?.toJson(),
      };
}
