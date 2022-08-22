class PhoneCodeModel {
  String? gambar;
  String? idposisi;
  String? name;
  String? dialCode;
  String? code;

  PhoneCodeModel({
    required this.gambar,
    required this.idposisi,
    required this.name,
    required this.dialCode,
    required this.code,
  });

  PhoneCodeModel.fromJson(Map<String, dynamic> json) {
    gambar = json["gambar"];
    idposisi = json["idposisi"];
    name = json["name"];
    dialCode = json["dial_code"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    return {
      "gambar": gambar,
      "idposisi": idposisi,
      "name": name,
      "dial_code": dialCode,
      "code": code,
    };
  }
}
