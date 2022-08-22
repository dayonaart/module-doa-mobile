class Job {
  String id;
  String desc;

  Job({required this.id, required this.desc});
}

List<Job> jobList = [
  Job(id: '01', desc: 'PEGAWAI NEGERI'),
  Job(id: '02', desc: 'PEGAWAI SWASTA'),
  Job(id: '03', desc: 'PEGAWAI BUMN/BUMD'),
  Job(id: '04', desc: 'TNI/POLRI'),
  Job(id: '05', desc: 'PENGUSAHA'),
  Job(id: '06', desc: 'PEDAGANG'),
  Job(id: '07', desc: 'PETANI/NELAYAN'),
  Job(id: '08', desc: 'PELAJAR/MAHASISWA'),
  Job(id: '09', desc: 'IBU RUMAH TANGGA'), //
  Job(id: '10', desc: 'TIDAK BEKERJA'),
  Job(id: '11', desc: 'BURUH'),
  Job(id: '12', desc: 'WIRASWASTA'),
  Job(id: '14', desc: 'AKUNTAN'),
  Job(id: '15', desc: 'PENGACARA/NOTARIS'),
  Job(id: '16', desc: 'PROFESI'),
  Job(id: '17', desc: 'PENSIUNAN'),
  Job(id: '18', desc: 'DOSEN/GURU SWASTA'),
  Job(id: '19', desc: 'DOSEN/GURU NEGERI'),
  Job(id: '20', desc: 'DOKTER'),
  Job(id: '21', desc: 'PEGAWAI BNI'),
  Job(id: '22', desc: 'UNIT AFILIASI BNI'),
  Job(id: '23', desc: 'TENAGA KERJA INDONESIA'),
];

class Income {
  String id;
  String desc;

  Income({required this.id, required this.desc});
}

List<Income> incomeList = [
  Income(id: '1', desc: '< Rp. 3 JUTA'),
  Income(id: '2', desc: 'Rp. 3 JUTA S/D < 5 JUTA'),
  Income(id: '3', desc: 'Rp. 5 JUTA S/D < 10 JUTA'),
  Income(id: '4', desc: 'Rp. 10 JUTA S/D < 20 JUTA'),
  Income(id: '5', desc: 'Rp. 20 JUTA S/D < 50 JUTA'),
  Income(id: '6', desc: 'Rp. 50 JUTA S/D < 100 JUTA'),
  Income(id: '7', desc: 'Rp. 100 JUTA S/D < 500 JUTA'),
  Income(id: '8', desc: '>= Rp. 500 JUTA'),
];

class SourceOfFund {
  String id;
  String desc;

  SourceOfFund({required this.id, required this.desc});
}

List<SourceOfFund> sourceOfFundList = [
  SourceOfFund(id: '1', desc: 'GAJI'),
  SourceOfFund(id: '2', desc: 'HASIL USAHA'),
  SourceOfFund(id: '3', desc: 'HASIL INVESTASI'),
  SourceOfFund(id: '4', desc: 'HIBAH / WARISAN'),
  SourceOfFund(id: '5', desc: 'LAINNYA'),
];

class TransactionEstimation {
  String id;
  String desc;

  TransactionEstimation({required this.id, required this.desc});
}

List<TransactionEstimation> transactionEstimationList = [
  TransactionEstimation(id: '1', desc: '< Rp 5 JUTA'),
  TransactionEstimation(id: '2', desc: 'Rp 5 JUTA S/D < Rp 25 JUTA'),
  TransactionEstimation(id: '3', desc: 'Rp 25 JUTA S/D < Rp 100 JUTA'),
  TransactionEstimation(id: '4', desc: 'Rp 100 JUTA S/D < Rp 250 JUTA'),
  TransactionEstimation(id: '5', desc: 'Rp 250 JUTA S/D < Rp 500 JUTA'),
  TransactionEstimation(id: '6', desc: '>= Rp 500 JUTA'),
];

class OpenAccReason {
  String id;
  String desc;

  OpenAccReason({required this.id, required this.desc});
}

List<OpenAccReason> openAccReasonList = [
  OpenAccReason(id: '2', desc: 'INVESTASI'),
  OpenAccReason(id: '6', desc: 'SIMPANAN'),
  OpenAccReason(id: '7', desc: 'TRANSAKSI'),
];
