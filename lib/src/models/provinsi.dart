class Provinsi {
  String id;
  String provinsi;

  Provinsi(this.id, this.provinsi);
  factory Provinsi.fromJson(dynamic json) {
    return Provinsi(json['id'] as String, json['provinsi'] as String);
  }
}
