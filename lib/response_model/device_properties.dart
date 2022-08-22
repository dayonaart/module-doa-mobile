class DeviceProperties {
  String? ipAddress;
  String? deviceType;
  String? osVersion;
  String? versionName;
  String? versionCode;

  DeviceProperties({
    this.ipAddress,
    this.deviceType,
    this.osVersion,
    this.versionName,
    this.versionCode,
  });

  factory DeviceProperties.fromJson(Map<String, dynamic> json) {
    return DeviceProperties(
      ipAddress: json['ip_address'] as String?,
      deviceType: json['device_type'] as String?,
      osVersion: json['os_version'] as String?,
      versionName: json['version_name'] as String?,
      versionCode: json['version_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'ip_address': ipAddress,
        'device_type': deviceType,
        'os_version': osVersion,
        'version_name': versionName,
        'version_code': versionCode,
      };
}
