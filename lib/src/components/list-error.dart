class ListError {
  errorMessage(String code) {
    String result = "";

    if (code.contains("9001")) {
      result =
          "Mohon maaf. Anda sudah melakukan maksimal percobaan pengiriman Kode OTP sebanyak 3 (tiga) kali. \n\nSilahkan lakukan pembukaan rekening keesokan hari atau kunjungi Kantor Cabang BNI terdekat.";
    } else if (code.contains("9002")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("9003")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("9004")) {
      result = "OTP yang Anda masukan belum sesuai.";
    } else if (code.contains("9005")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("9006")) {
      result =
          "Mohon maaf validasi data Anda tidak sesuai. Silahkan kunjungi Kantor Cabang BNI terdekat atau hubungi BNI Call 1500046.";
    } else if (code.contains("9007")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("9008")) {
      result =
          "NIK yang digunakan telah membuka rekening melalui fitur ini. Manfaatkan fitur pembukaan rekening pada BNI Mobile Banking atau datangi kantor cabang BNI terdekat.";
    } else if (code.contains("9009")) {
      result =
          "Mohon melengkapi data-data yang belum terisi sebelum melanjutkan proses pembukaan rekening.";
    } else if (code.contains("9010")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("9011")) {
      result =
          "OTP yang Anda isi tidak cocok dan telah melebihi batas kesalahan sebanyak 3 kali. Silahkan datangi kantor cabang terdekat untuk melakukan pembukaan rekening.";
    } else if (code.contains("9012")) {
      result =
          "Identitas Anda telah terdaftar sebagai Nasabah BNI. Anda dapat melakukan pembukaan rekening tabungan melalui BNI Mobile Banking pada menu Rekeningku atau kunjungi kantor cabang BNI terdekat. \n\nInfo lebih lanjut hubungi BNI Call 1500046.";
    } else if (code.contains("9013")) {
      result =
          "Mohon maaf verifikasi foto Anda tidak sesuai. Silahkan kunjungi Kantor Cabang BNI terdekat atau hubungi BNI Call 1500046.";
    } else if (code.contains("9014")) {
      result =
          "Data kependudukan (nik) tidak ditemukan. Silahkan kunjungi Kantor Cabang BNI terdekat atau hubungi BNI Call 1500046.";
    } else if (code.contains("9017")) {
      result =
          "Anda telah mencapai batas percobaan validasi wajah. Anda dapat mencoba kembali pembukaan tabungan keesokan hari atau kunjungi kantor cabang BNI terdekat.";
    } else if (code.contains("9025")) {
      result =
          "Identitas Anda telah terdaftar sebagai Nasabah BNI. Anda dapat melakukan pembukaan rekening tabungan melalui BNI Mobile Banking pada menu Rekeningku atau kunjungi kantor cabang BNI terdekat. \n\nInfo lebih lanjut hubungi BNI Call 1500046.";
    } else if (code.contains("9081")) {
      result =
          "Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    } else if (code.contains("4832")) {
      result = "(ICONS) INVALID CODE POS";
    } else if (code.contains("9301")) {
      result = "(ICONS) NO CONNECTION TO BACK-END";
    } else if (code.contains("0545")) {
      result = "(ICONS) APPLICATION NOT ACTIVE";
    } else if (code.contains("3211")) {
      result = "(ICONS) INVALID TFN : TFN PROCESSING NOT ENABLED";
    } else if (code.contains("9201")) {
      result = "(ICONS) LATE RESPONSE FROM BACK-END";
    } else if (code.contains("RCS")) {
      result =
          "User ID yang Anda masukkan telah terdaftar di sistem BNI Mobile Banking, silahkan masukkan user ID lainnya";
    } else {
      result =
          "(OTHER) Mohon maaf terjadi kesalahan. Silahkan mengulangi proses pembukaan rekening.";
    }

    return result;
  }

  validateErrorMessage(String code) {
    String result = "";

    if (code.contains("9015")) {
      result =
          "Isian data Nama Sesuai KTP yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9016")) {
      result =
          "Isian data Tanggal Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9017")) {
      result =
          "Isian data Nama Sesuai KTP dan Tanggal Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9018")) {
      result =
          "Isian data Tempat Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9019")) {
      result =
          "Isian data Nama Sesuai KTP dan Tempat Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9020")) {
      result =
          "Isian data Tanggal Lahir dan Tempat Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else if (code.contains("9021")) {
      result =
          "Isian data Nama Sesuai KTP, Tanggal Lahir, dan Tempat Lahir yang diisi belum sesuai dengan data kependudukan. Mohon periksa kembali data yang diisi dan ulangi proses pembukaan rekening.";
    } else {
      result =
          "Validate \n\nMohon periksa kembali data yang diisi dan pastikan sudah sesuai dengan data kependudukan kemudian ulangi proses pembukaan rekening.";
    }

    return result;
  }
}
