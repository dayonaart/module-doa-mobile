import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

class MobileBankingAcknowledgementScreen extends StatelessWidget {
  const MobileBankingAcknowledgementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List attributeAck = [
      "Tanggal Registrasi",
      "Waktu Registrasi",
      "User ID",
      "Alamat Email",
    ];

    /// ini value dummy static yang nantinya diganti secara dynamic
    List valueDummy = [
      "21 Oktober 2022",
      "12:30:01 WIB",
      "LoremA20",
      "lorem.sangipsum@gmail.com",
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 239, 250),
      floatingActionButton: ButtonCostum(
        ontap: () {},
        text: "Selanjutnya",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/simpanan-jempol-icon.png")),
                Center(
                    child: Text(
                  "Yeay!",
                  style: blackRoboto.copyWith(fontWeight: FontWeight.normal, fontSize: 50),
                )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 30, top: 20),
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Text(
                    "Terima kasih atas kepercayaan Anda telah melakukan registrasi BNI Mobile Banking dengan detail sebagai berikut.",
                    textAlign: TextAlign.justify,
                    style: blackRoboto.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (var i = 0; i < attributeAck.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                attributeAck[i],
                                style: blackRoboto.copyWith(
                                    fontWeight: FontWeight.normal, fontSize: 13),
                              )),
                          Expanded(
                              child: Text(
                            valueDummy[i],
                            textAlign: TextAlign.left,
                            style: blackRoboto.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: CustomThemeWidget.mainOrange),
                          ))
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pastikan registrasi terjadi atas inisiatif Anda. Mohon simpan dan jaga kerahasiaan data BNI Mobile Banking Anda. Untuk informasi lebih lanjut hubungi BNI Call 1500046",
                    textAlign: TextAlign.justify,
                    style: blackRoboto.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Salam hangat,\nPT Bank Negara Indonesia(Persero) Tbk.",
                    textAlign: TextAlign.center,
                    style: blackRoboto.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
