//Jangan digunain dulu cuma contoh

class DataDiri1ModelPref {
  String? nik;
  String? nama;
  String? tanggalLahir;
  String? kodeReferal;

  DataDiri1ModelPref({
    this.nik,
    this.nama,
    this.tanggalLahir,
    this.kodeReferal,
  });

  factory DataDiri1ModelPref.fromJson(Map<String, dynamic> json) {
    return DataDiri1ModelPref(
      nik: json['nik'] as String?,
      nama: json['nama'] as String?,
      tanggalLahir: json['tanggal_lahir'] as String?,
      kodeReferal: json['kode_referal'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'nik': nik,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'kode_referal': kodeReferal,
      };
}
