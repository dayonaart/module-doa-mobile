import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

Widget deskripsiKartuSilver() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keuntungan & Manfaat',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        listedText('Kenyamanan dalam bertransaksi dengan teknologi Chip dan 6 digit PIN\n',
            'Kartu Debit BNI telah dilengkapi dengan teknologi Chip dan 6 digit PIN, untuk meningkatkan keamanan transaksi.\n'),
        listedText('Nyaman berbelanja tanpa uang tunai\n',
            'Berbelanja dengan mudah tanpa uang tunai dengan menggunakan Kartu Debit BNI Chip diberbagai tempat di mesin EDC berlogo GPN untuk transaksi dalam negeri dan juga di mesin EDC berlogo Mastercard untuk transaksi di luar negeri.\n'),
        listedText('Berbagai promo sepanjang tahun\n',
            'Dapatkan beragam penawaran menarik saat berbelanja di merchant yang bekerjasama dengan BNI sepanjang tahun.\n'),
        listedText('Transaksi belanja online\n',
            'Nikmat kenyamanan transaksi pembayaran belanja online diberbagai merchant online / e-commerce kapanpun dengan mudah dan aman dengan Kartu Debit BNI Chip Mastercard® dengan teknologi 3D Secure. Pastikan Anda sudah aktivasi BNI Mobile Banking agar dapat melakukan transaksi belanja online.\n'),
        Text(
          'Fitur Kartu',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Transaksi Tarik Tunai', false),
          pointedText('', 'Rp 5  Juta/hari', true),
        ),
        rowtext(
          pointedText('b.', 'Pembelanjaan', false),
          pointedText('', 'Nominal Transaksi:\nRp 10 Juta/hari', true),
        ),
        rowtext(
          pointedText('c.', 'Transfer Antar Rekening BNI via ATM', false),
          pointedText('', 'Rp 50 Juta/hari', true),
        ),
        rowtext(
          pointedText('d.', 'Transfer Antar Bank via ATM', false),
          pointedText('', 'Rp 10 Juta/hari', true),
        ),
        rowtext(
          pointedText('e.', 'e-Channel & fitur', false),
          Column(
            children: [
              pointedText('',
                  'Internet Banking, SMS Banking, Phone Banking, Mobile Banking dan QRIS', true),
              pointedText('', 'Transaksi Online (3D Secure dan BNI Debit)', true),
            ],
          ),
        ),
        Text(
          'Fee dan Charges',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Biaya Pengelolaan Kartu per bulan', false),
          pointedText('', 'Rp 4.000', true),
        ),
        rowtext(
          pointedText('b.', 'Biaya Penerbitan Kartu Debit', false),
          Column(
            children: [
              pointedText('', 'Baru: Rp 15.000,-', true),
              pointedText('', 'Pengganti: Rp 20.000,-', true),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    ),
  );
}

Widget deskripsiKartuBatik() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keuntungan & Manfaat',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        listedText('Reward Cashback Transaksi\n',
            'Rewards cashback 5% per bulan, maksimum cashback Rp100.000,- setiap bulan, dengan minimal transaksi belanja setiap bulannya Rp 1.5 juta. Hanya berlaku untuk transaksi pembelian tiket pesawat di channel resmi milik Lion Group.\n'),
        listedText('Cashback Top Spender\n',
            'Cashback Rp100.000,- untuk 20 orang Top Spender setiap bulan. Dengan syarat minimal transaksi belanja Rp 3 juta di semua merchant.\n'),
        listedText('Special Line Check-In\n', 'Line check-in khusus di selected bandara.\n'),
        listedText('Extra Baggage\n', 'Extra Baggage 10 kg\nKhusus Periode: Maret - Juli 2022.\n'),
        listedText('Combo Card\n',
            'Kartu Debit dan Tapcash dalam 1 kartu, saldo maksimal Tapcash Rp 2 juta.\n'),
        Text(
          'Fitur Kartu',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Transaksi Tarik Tunai', false),
          pointedText('', 'Rp 15 Juta/hari', true),
        ),
        rowtext(
          pointedText('b.', 'Pembelanjaan', false),
          pointedText('', 'Nominal Transaksi:\nRp 100 Juta/hari', true),
        ),
        rowtext(
          pointedText('c.', 'Transfer Antar Rekening BNI via ATM', false),
          pointedText('', 'Rp 100 Juta/hari', true),
        ),
        rowtext(
          pointedText('d.', 'Transfer Antar Bank via ATM', false),
          pointedText('', 'Rp 50 Juta/hari', true),
        ),
        rowtext(
          pointedText('e.', 'e-Channel & fitur', false),
          Column(
            children: [
              pointedText('',
                  'Internet Banking, SMS Banking, Phone Banking, Mobile Banking dan QRIS', true),
              pointedText('', 'Transaksi Online (3D Secure dan BNI Debit)', true),
            ],
          ),
        ),
        Text(
          'Fee dan Charges',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Biaya Pengelolaan Kartu per bulan', false),
          pointedText('', 'Rp 10.000', true),
        ),
        rowtext(
            pointedText('b.', 'Biaya Penerbitan Kartu Debit', false),
            Column(
              children: [
                pointedText('', 'Baru: Rp 25.000,-', true),
                pointedText('', 'Pengganti: Rp 25.000,-', true),
              ],
            )),
        SizedBox(
          height: 100,
        )
      ],
    ),
  );
}

Widget deskripsiKartuGold() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keuntungan & Manfaat',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        listedText('Kenyamanan dalam bertransaksi dengan teknologi Chip dan 6 digit PIN\n',
            'Kartu Debit BNI telah dilengkapi dengan teknologi Chip dan 6 digit PIN, untuk meningkatkan keamanan transaksi.\n'),
        listedText('Nyaman berbelanja tanpa uang tunai\n',
            'Berbelanja dengan mudah tanpa uang tunai dengan menggunakan Kartu Debit BNI Chip diberbagai tempat di mesin EDC berlogo GPN untuk transaksi dalam negeri dan juga di mesin EDC berlogo Mastercard untuk transaksi di luar negeri.\n'),
        listedText('Berbagai promo sepanjang tahun\n',
            'Dapatkan beragam penawaran menarik saat berbelanja di merchant yang bekerjasama dengan BNI sepanjang tahun.\n'),
        listedText('Transaksi belanja online\n',
            'Nikmat kenyamanan transaksi pembayaran belanja online diberbagai merchant online / e-commerce kapanpun dengan mudah dan aman dengan Kartu Debit BNI Chip Mastercard® dengan teknologi 3D Secure. Pastikan Anda sudah aktivasi BNI Mobile Banking agar dapat melakukan transaksi belanja online.\n'),
        Text(
          'Fitur Kartu',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Transaksi Tarik Tunai', false),
          pointedText('', 'Rp 15 Juta/hari', true),
        ),
        rowtext(
          pointedText('b.', 'Pembelanjaan', false),
          pointedText('', 'Nominal Transaksi:\nRp 50 Juta/hari', true),
        ),
        rowtext(
          pointedText('c.', 'Transfer Antar Rekening BNI via ATM', false),
          pointedText('', 'Rp 100 Juta/hari', true),
        ),
        rowtext(
          pointedText('d.', 'Transfer Antar Bank via ATM', false),
          pointedText('', 'Rp 25 Juta/hari', true),
        ),
        rowtext(
          pointedText('e.', 'e-Channel & fitur', false),
          Column(
            children: [
              pointedText('',
                  'Internet Banking, SMS Banking, Phone Banking, Mobile Banking dan QRIS', true),
              pointedText('', 'Transaksi Online (3D Secure dan BNI Debit)', true),
            ],
          ),
        ),
        Text(
          'Fee dan Charges',
          style: orangeText.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        rowtext(
          pointedText('a.', 'Biaya Pengelolaan Kartu per bulan', false),
          pointedText('', 'Rp 7.500', true),
        ),
        rowtext(
          pointedText('b.', 'Biaya Penerbitan Kartu Debit', false),
          Column(
            children: [
              pointedText('', 'Baru: Rp 15.000,-', true),
              pointedText('', 'Pengganti: Rp 20.000,-', true),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        )
      ],
    ),
  );
}

Widget pointedText(String huruf, String deskripsi, bool dot) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dot
          ? Padding(
              padding: const EdgeInsets.only(top: 15, left: 8, right: 5),
              child: Icon(Icons.circle, size: 4),
            )
          : Text(
              huruf,
              style: bodyStyle,
            ),
      SizedBox(
        width: 4,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deskripsi,
              style: bodyStyle,
            )
          ],
        ),
      ),
    ],
  );
}

Widget listedText(String header, String deskripsi) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 8, right: 5),
        child: Icon(Icons.circle, size: 4),
      ),
      SizedBox(
        width: 4,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: header,
                    style: semibold14,
                  ),
                  TextSpan(text: deskripsi, style: infoStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget rowtext(
  Widget deskripsi,
  Widget value,
) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(flex: 4, child: deskripsi),
          Expanded(
            flex: 4,
            child: value,
          )
        ],
      ),
    ],
  );
}
