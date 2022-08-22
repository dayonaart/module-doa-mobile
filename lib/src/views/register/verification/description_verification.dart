import 'package:flutter/material.dart';

import '../../../components/theme_const.dart';

class DescriptionVerification extends StatelessWidget {
  const DescriptionVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. ",
              style: blackRoboto.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                "Apabila terdapat indikasi akun WhatsApp Anda digunakan oleh pihak lain, jangan berikan OTP kepada pihak lain termasuk kepada Petugas Bank.",
                style: blackRoboto.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2. ",
              style: blackRoboto.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                children: [
                  Text(
                    "Pastikan Anda sudah mengaktifkan Two-Step Verification untuk menjaga keamanan & menghindari pengambilalihan akun,  dengan cara:",
                    style: blackRoboto.copyWith(
                        fontWeight: FontWeight.normal, fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. ",
                        style: blackRoboto.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Buka aplikasi WhatsApp, lalu pilih Settings/Pengaturan",
                          style: blackRoboto.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2. ",
                        style: blackRoboto.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Pilih Akun, lalu pilih Two-Step Verification",
                          style: blackRoboto.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3. ",
                        style: blackRoboto.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Masukkan PIN WhatsApp dan konfirmasi kembali PIN WhatsApp ",
                          style: blackRoboto.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4. ",
                        style: blackRoboto.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Daftarkan email sebagai alamat konfirmasi apabila lupa PIN WhatsApp ",
                          style: blackRoboto.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "3. ",
              style: blackRoboto.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                "Pastikan Anda memiliki akses WhatsApp ke nomor yang Anda daftarkan saat membuka rekening.",
                style: blackRoboto.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "4. ",
              style: blackRoboto.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                "Tetap jaga kerahasiaan data pribadi seperti User ID, MPIN,  Password Transaksi, dan data pribadi lainnya.",
                style: blackRoboto.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
