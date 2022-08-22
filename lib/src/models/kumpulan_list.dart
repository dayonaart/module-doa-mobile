class JenisKelamin {
  String id;
  String desc;
  JenisKelamin({required this.id, required this.desc});
}

List<JenisKelamin> jeniskelaminList = [
  JenisKelamin(id: 'M', desc: 'PRIA'),
  JenisKelamin(id: 'F', desc: 'WANITA'),
];

class Agama {
  String id;
  String desc;

  Agama({required this.id, required this.desc});
}

List<Agama> agamaList = [
  Agama(id: '1', desc: 'ISLAM'),
  Agama(id: '2', desc: 'KRISTEN'),
  Agama(id: '3', desc: 'KATOLIK'),
  Agama(id: '4', desc: 'BUDDHA'),
  Agama(id: '5', desc: 'HINDU'),
  Agama(id: '6', desc: 'KONGHUCU'),
];

class StatusPerkawinan {
  String id;
  String desc;

  StatusPerkawinan({required this.id, required this.desc});
}

List<StatusPerkawinan> statusPerkawinanList = [
  StatusPerkawinan(id: 'S', desc: 'LAJANG'),
  StatusPerkawinan(id: 'M', desc: 'MENIKAH'),
  StatusPerkawinan(id: 'D', desc: 'DUDA'),
  StatusPerkawinan(id: 'W', desc: 'JANDA'),
];
