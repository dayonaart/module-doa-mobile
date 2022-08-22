import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/views/buka-rekening/home-buka-rekening.dart';
import 'package:eform_modul/src/views/home-page/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/deskripsi-kartu.dart';
import '../../utility/Routes.dart';
import '../../utility/syarat-dan-ketentuan.dart';

class SyaratDanKetentuanPage extends StatefulWidget {
  const SyaratDanKetentuanPage({Key? key}) : super(key: key);

  @override
  _SyaratDanKetentuanPageState createState() => _SyaratDanKetentuanPageState();
}

class _SyaratDanKetentuanPageState extends State<SyaratDanKetentuanPage> {
  var isRequirementExpanded = false; //syarat
  var isConsumptionExpanded = false; //peggunaan

  var isRequirementAccept = false;
  var isConsumptionAccept = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => HomeBukaRekening(), transition: Transition.rightToLeft);
        return true;
      },
      child: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Scaffold(
              appBar: AppBar(
                elevation: 1,
                leading: LeadingIcon(
                  context: context,
                  onPressed: () {
                    Get.off(() => HomeBukaRekening(), transition: Transition.rightToLeft);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomeScreeen(),
                    //   ),
                    // );
                  },
                ),
                backgroundColor: CustomThemeWidget.backgroundColorTop,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Text("Syarat Ketentuan", style: appBar_Text),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 180),
                  child: Column(
                    children: [
                      getDropDownContainer(
                        function: () {
                          setState(() {
                            isRequirementExpanded = !isRequirementExpanded;
                          });
                        },
                        isExpanded: isRequirementExpanded,
                        text1: 'A. ',
                        text2: 'Syarat dan Ketentuan Rekening Tabungan',
                        text3: 'Perorangan',
                        content: requirmentContent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Divider(),
                      ),
                      getDropDownContainer(
                        function: () {
                          setState(
                            () {
                              isConsumptionExpanded = !isConsumptionExpanded;
                            },
                          );
                        },
                        isExpanded: isConsumptionExpanded,
                        text1: 'B. ',
                        text2: 'Persetujuan Penawaran Produk dan Jasa',
                        text3: 'Layanan',
                        content: penggunaanContent,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isRequirementAccept = !isRequirementAccept;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 18, left: 15, right: 20),
                            child: Row(
                              children: [
                                isRequirementAccept
                                    ? SvgPicture.asset(
                                        "assets/images/icons/fill_checkbox.svg",
                                        height: 24,
                                        width: 24,
                                      )
                                    : SvgPicture.asset(
                                        "assets/images/icons/blank_checkbox.svg",
                                        height: 24,
                                        width: 24,
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Saya Setuju dengan ',
                                          style: semibold14,
                                        ),
                                        TextSpan(
                                            text:
                                                '"Syarat dan ketentuan Rekening tabungan perorangan"',
                                            style: orangeText),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isConsumptionAccept = !isConsumptionAccept;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 15, right: 20),
                          child: Row(
                            children: [
                              isConsumptionAccept
                                  ? SvgPicture.asset(
                                      "assets/images/icons/fill_checkbox.svg",
                                      height: 24,
                                      width: 24,
                                    )
                                  : SvgPicture.asset("assets/images/icons/blank_checkbox.svg"),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Saya Setuju dengan ',
                                        style: semibold14,
                                      ),
                                      TextSpan(
                                          text: '"Persetujuan Penawaran Produk dan Jasa Layanan"',
                                          style: orangeText),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              // floatingActionButton: buttonNavigasi(),
              floatingActionButton: ButtonCostum(
                text: "Lanjut",
                ontap: !isRequirementAccept
                    ? null
                    : (() {
                        Get.toNamed(Routes().registrasinomor);
                      }),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 25,
            child: GestureDetector(
              onTap: _scrollToTop,
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 238, 238),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Icon(
                  Icons.expand_less,
                  color: Color(0xFFD45E30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  Widget getDropDownContainer(
      {required VoidCallback function,
      required bool isExpanded,
      String text1 = '',
      String text2 = '',
      String text3 = '',
      String content = ""}) {
    return InkWell(
      onTap: function,
      child: Container(
        // padding: const EdgeInsets.all(18),
        padding: EdgeInsets.only(left: 24, right: 24, top: text1 == 'A. ' ? 32 : 24, bottom: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1, child: Text(text1, style: semibold14.copyWith(height: 1.2))),
                        Expanded(
                            flex: 17,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(text2 + " " + text3, style: semibold14.copyWith(height: 1.2)),
                                // Text(text3,
                                //     style: semibold14.copyWith(height: 1.2)),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                isExpanded
                    ? const Icon(
                        Icons.expand_less,
                        color: Color(0xFFD45E30),
                      )
                    : const Icon(
                        Icons.expand_more,
                        color: Color(0xFFD45E30),
                      ),
              ],
            ),
            isExpanded ? dropdownContent(text1) : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget dropdownContent(String text1) {
    if (text1 == 'A. ') {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Dengan ini, saya/kami sebagai pemohon, selanjutnya disebut \"Nasabah\", menyatakan setuju atas semua Ketentuan Umum dan Persyaratan Pembukaan Rekening yang berlaku di PT. Bank Negara Indonesia (Persero) Tbk, yang selanjutnya disebut \"Bank\", sebagai berikut :\n",
              style: infoStyle,
            ),
            Text(
              "I. Rekening\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Rekening adalah catatan pembukuan Bank atas produk simpanan yang dibuka oleh Nasabah perorangan pada Bank baik dalam Rupiah maupun mata uang asing atas dasar permohonan tertulis dari Nasabah atau melalui permohonan nasabah melalui sistem e-Banking milik Bank menurut tata cara dan persyaratan yang tercantum baik dalam Ketentuan Umum dan Persyaratan Pembukaan Rekening ini maupun dalam Ketentuan Umum dan Persyaratan Pembukaan Rekening melalui Elektronik Banking (e-Banking)',
                false),
            pointedText(
                '2.',
                'Dalam hal Rekening dibuka dengan mata uang asing maka Bank tidak bertanggung jawab atas perubahan nilai mata uang asing terhadap Rupiah.',
                false),
            pointedText('3.', 'Jenis-jenis Rekening adalah Tabungan.', false),
            pointedText(
                '4.',
                'Pengertian Rekening sebagaimana dimaksud pada butir I.1 mencakup Rekening Gabungan yaitu Rekening yang dimiliki oleh lebih dari satu Nasabah yang dapat terdiri dari gabungan orang pribadi. Perjanjian pembukaan Rekening Gabungan dituangkan dalam Perjanjian tersendiri dan wajib pula ditandatangani oleh seluruh Nasabah anggota Rekening Gabungan.',
                false),
            pointedText(
                '5.',
                'Bilamana Nasabah membuka lebih dari satu Rekening pada Bank, baik pada satu Kantor Cabang Bank maupun lebih, maka seluruh Rekening tersebut disetujui oleh Nasabah sebagai satu kesatuan.',
                false),
            pointedText(
                '6.',
                'Bank atas pertimbangannya sendiri berhak menolak permohonan pembukaan Rekening oleh Nasabah dan memberitahukan kepada calon nasabah.\n',
                false),
            Text(
              "II. Data Nasabah/Customer Information File\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Dalam rangka penggunaan produk/fasilitas/jasa Bank, Nasabah wajib menunjukkan dan menyampaikan informasi, data dan dokumen pendukung yang dipersyaratkan Bank sebagaimana yang disampaikan oleh Petugas Bank dan dimuat dalam media resmi Bank.',
                false),
            pointedText(
                '2.',
                'Bank berhak meminta informasi, data dan dokumen pendukung serta menatakerjakan data profil Nasabah sesuai dengan kebutuhan dan peraturan perundang-undangan yang berlaku.',
                false),
            pointedText(
                '3.',
                'Nasabah dengan ini menjamin bahwa semua data, informasi dan dokumen pendukung yang ditunjukkan dan diserahkan kepada Bank adalah benar, lengkap, asli, sah dan terbaru sesuai dengan peraturan perundang-undangan yang berlaku.',
                false),
            pointedText(
                '4.',
                'Nasabah wajib segera memberitahukan dan menyampaikan kepada Bank setiap perubahan data, informasi dan dokumen pendukung yang dipersyaratkan Bank. Perubahan tersebut efektif berlaku setelah diterima dan/atau disetujui Bank.',
                false),
            pointedText(
                '5.',
                'Nasabah dengan ini menyatakan bertanggung jawab sepenuhnya atas segala kerugian dan risiko yang dialami sebagai akibat dari kelalaian/keterlambatan/tidak diberitahukannya perubahan sebagaimana diatur dalam butir II.4 tersebut kepada Bank.\n',
                false),
            Text(
              "III. Transaksi\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Transaksi adalah kegiatan pembukuan pada suatu Rekening termasuk penambahan saldo dan pengurangan saldo pada Rekening yang pengaturannya mengacu pada media resmi Bank.',
                false),
            pointedText(
                '2.',
                'Dana yang disetorkan/dipergunakan/ditransaksikan pada Bank tidak berasal dari/untuk tujuan tindak pidana pencucian uang (money laundering).',
                false),
            pointedText(
                '3.',
                'Setiap Transaksi yang menggunakan surat berharga/warkat kliring dan sarana perbankan lainnya berlaku pula ketentuan perundang-undangan yang mengatur tentang hal tersebut.',
                false),
            pointedText(
                '4.',
                'Nasabah bertanggung jawab sepenuhnya atas keamanan perintah Transaksi/surat berharga yang diberikan kepada Bank, termasuk penyalahgunaan dalam bentuk apapun, pemalsuan, dan penggandaan yang menyebabkan tindak kejahatan.',
                false),
            pointedText(
                '5.',
                'Apabila Rekening dibuka dalam mata uang asing maka penarikan dana dalam mata uang asing yang sama tergantung pada ketersediaan mata uang asing tersebut pada Bank dan tunduk pada ketentuan Bank mengenai komisi sebagaimana yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '6.',
                'Penarikan dana di rekening dalam mata uang yang berbeda tergantung pada ketersediaan mata uang asing tersebut pada Bank dan tunduk pada ketentuan Bank mengenai komisi dan nilai tukar mata uang tersebut sebagaimana yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '7.',
                'Setoran dalam mata uang kertas atau mata uang asing yang sama akan diberlakukan dengan cara sesuai dengan peraturan dan ketentuan yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '8.',
                'Dalam rangka memenuhi peraturan perundang-undangan yang berlaku maupun atas pertimbangan Bank sendiri, Bank berhak menunda, menolak dan/atau membatalkan Transaksi dan memberitahukan kepada Nasabah/Calon Nasabah.',
                false),
            pointedText(
                '9.',
                'Pelaksanaan transaksi valuta asing terhadap Rupiah yang dilakukan oleh Nasabah wajib mengikuti ketentuan dan peraturan perundang-undangan yang berlaku, termasuk kewajiban untuk menyerahkan dokumen-dokumen yang dipersyaratkan oleh kebijakan Bank dan/atau peraturan Bank Indonesia dan/atau Peraturan pemerintah yang berlaku dan dipedomani oleh Bank',
                false),
            pointedText(
                '10.',
                'Apabila terdapat perbedaan antara catatan pembukuan Bank dengan catatan yang ada pada Nasabah, maka yang berlaku adalah catatan pembukuan Bank, dan dengan ini nasabah menyatakan, mengetahui, memahami, mengakui dan menerima bahwa catatan pembukuan Bank merupakan alat bukti yang sah dan mengikat Nasabah.\n',
                false),
            Text(
              "IV. Bunga, Pajak, dan Biaya\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Pendapatan bunga yang diterima oleh Nasabah akan dikenakan pajak yang besarnya sesuai dengan ketentuan perpajakan yang berlaku.',
                false),
            pointedText(
                '2.',
                'Ketentuan mengenai bunga yang diterima dan pajak atas bunga yang diterima serta biaya yang harus ditanggung oleh Nasabah terkait dengan produk/fasilitas/jasa Bank ditentukan oleh Bank, dan dapat berubah sewaktu-waktu, dengan pemberitahuan terlebih dahulu dari Bank kepada Nasabah melalui media resmi Bank. Dengan ini, Nasabah memberikan kuasa kepada Bank untuk sewaktu-waktu mendebet Rekening Nasabah untuk keperluan pembayaran pajak dan biaya dimaksud.\n',
                false),
            Text(
              "V. Nasabah Meninggal Dunia\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Dalam hal Nasabah meninggal dunia atau dinyatakan pailit atau diletakkan dibawah pengawasan pihak yang ditunjuk untuk itu, Bank sewaktu-waktu berhak untuk menonaktifkan rekening Nasabah dan hanya akan mengalihkan/menyerahkan hak Nasabah kepada ahli waris atau pihak yang sah yang ditunjuk sesuai ketentuan Bank sebagaimana yang tertuang dalam media resmi Bank maupun peraturan perundang-undangan yang berlaku.',
                false),
            pointedText(
                '2.',
                'Bank berhak meminta dokumen yang dapat diterima sebagai bukti yang sah bagi Bank terkait kedudukan ahli waris atau pihak yang ditunjuk sebagaimana dimaksud.\n',
                false),
            Text(
              "VI. Kehilangan dan Penyalahgunaan Rekening/Fasilitas Lainnya\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Dalam hal bukti kepemilikan Rekening hilang, maka Nasabah wajib memberitahukan kepada Bank, melalui Kantor Cabang terdekat selama jam kerja dengan disertai dokumen pendukung sebagaimana yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '2.',
                'Dalam hal kartu ATM atau perangkat fasilitas Transaksi Bank melalui sarana elektronik/e-Banking (telepon seluler, BNI e-Secure/m-Secure, dsb) hilang atau terjadi permasalahan atas penggunaan fasilitas e-Banking, maka Nasabah wajib memberitahukan kepada Bank, melalui Kantor Cabang BNI terdekat atau BNI Call di 1500046 atau melalui ponsel di (021)1500046/68888.',
                false),
            pointedText(
                '3.',
                'Bank akan segera melakukan pemblokiran atas Rekening dan/atau kartu ATM dan/atau penggunaan fasilitas e-Banking berdasarkan laporan Nasabah apabila terindikasi terjadi penyalahgunaan rekening yang dilengkapi dengan dokumen pendukung sebagaimana yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '4.',
                'Nasabah bertanggung jawab terhadap setiap transaksi yang terjadi sebelum diterimanya laporan kehilangan bukti kepemilikan Rekening dan/atau fasilitas lainnya dari Nasabah.',
                false),
            pointedText(
                '5.',
                'Bank berhak sesuai dengan pertimbangannya sendiri untuk tidak menerbitkan penggantian bukti kepemilikan Rekening yang dilaporkan hilang apabila Bank mencurigai adanya suatu keganjilan atau itikad tidak baik dari hilangnya bukti kepemilikan Rekening tersebut.',
                false),
            pointedText(
                '6.',
                'Setiap penggantian bukti kepemilikan Rekening dan/atau fasilitas lainnya yang dilaporkan hilang, Nasabah akan dikenakan biaya administrasi yang besarnya ditentukan oleh Bank yang tertuang pada media resmi Bank.',
                false),
            pointedText(
                '7.',
                'Nasabah bertanggung jawab sepenuhnya atas segala tuntutan dan kerugian yang timbul karena kehilangan/pemalsuan dan/atau penyalahgunaan bukti kepemilikan Rekening dan/atau tanda pengguna dan nomor identifikasi pribadi/perangkat fasilitas lainnya, yang dilakukan oleh Nasabah atau pihak lainnya.\n',
                false),
            Text(
              "VII. Ketentuan Umum Produk dan Fasilitas\n",
              style: semibold14,
            ),
            Text(
              "A. Tabungan",
              style: semibold14,
            ),
            SizedBox(
              height: 10,
            ),
            pointedText(
                '1.',
                'Sebagai bukti kepemilikan Rekening Tabungan, Bank menerbitkan Buku Tabungan, Kartu Debit BNI, atau Rekening Koran Elektronik (e-statement) yang ditetapkan oleh Bank dan bukti tersebut harus dipegang/disimpan Nasabah.',
                false),
            pointedText(
                '2.',
                'Nasabah wajib menunjukkan bukti kepemilikan Rekening setiap kali melakukan penarikan dana melalui teller Bank ataupun untuk memberikan instruksi Transaksi lainnya kepada Bank.',
                false),
            pointedText(
                '3.',
                'Untuk pembukaan Tabungan, Nasabah harus melakukan setoran sebesar minimum nominal yang dipersyaratkan Bank sesuai jenis tabungannya yang tertuang pada media resmi Bank.',
                false),
            pointedText(
                '4.',
                'atas minimum dan tata cara setoran berikutnya ke Rekening Tabungan ditetapkan sesuai jenis tabungannya sebagaimana tertuang dalam media resmi Bank. Dalam hal penyetoran ditetapkan dengan cara pemindahbukuan secara otomatis setiap bulan dari Rekening Nasabah lainnya (rekening afiliasi) maka Nasabah dengan ini memberi kuasa kepada Bank untuk melakukan pendebetan secara langsung Rekening Nasabah setiap bulan pada tanggal dan jumlah berdasarkan permintaan Nasabah. Bank tidak berkewajiban melaksanakan pendebetan jika saldo di rekening afiliasi tidak mencukupi.',
                false),
            pointedText(
                '5.',
                'Nasabah wajib memelihara saldo minimum yang dipersyaratkan oleh Bank sesuai jenis tabungannya. Nasabah akan dikenakan denda yang besarnya ditentukan Bank apabila saldo Tabungan dibawah saldo minimum yang saat ini berlaku maupun apabila terdapat perubahan. Ketentuan mengenai saldo minimum dan pengenaan denda yang dikenakan tertuang dalam media resmi Bank. Perubahan nominal saldo minimum atau denda ditetapkan oleh Bank dan akan diberitahukan kepada nasabah melalui media resmi Bank.',
                false),
            pointedText(
                '6.',
                'Catatan mutasi Transaksi Rekening Tabungan menggunakan Buku Tabungan, Rekening Koran elektronik (e-Statement) yang ditentukan oleh Bank. Dalam hal dipergunakan Buku Tabungan maka mutasi Transaksi Rekening Tabungan agar selalu di update (dicetak). Dalam hal laporan mutasi Transaksi Rekening dilakukan melalui pengiriman email oleh Bank (e-Statement), maka Nasabah wajib segera memberitahukan kepada Bank jika terdapat perubahan alamat email, dan perubahan tersebut efektif berlaku setelah diterima dan/atau disetujui Bank.',
                false),
            pointedText(
                '7.',
                'Terhadap jenis Tabungan yang memiliki ketentuan batasan usia maksimum yang dibuka oleh Nasabah, maka dalam hal Nasabah telah melewati batasan usia dimaksud, Bank berhak dengan ini melakukan konversi ke jenis Tabungan lainnya yang ditentukan oleh Bank dengan syarat dan ketentuan (antara lain fitur, bunga, biaya, dsb) mengikuti syarat dan ketentuan pada jenis Tabungan setelah konversi. Jenis tabungan yang memiliki batasan usia maksimum serta jenis tabungan setelah konversi adalah sebagaimana tertuang dalam media resmi Bank.',
                false),
            Text(
              "B. Rekening Koran Elektronik (E-Statement)",
              style: semibold14,
            ),
            SizedBox(
              height: 10,
            ),
            pointedText(
                '1.',
                'Bagi produk yang menggunakan sarana mutasi transaksi Rekening Koran Elektronik (e-Statement) maka Bank akan menerbitkan laporan berkala berupa Rekening Koran Elektronik (e-Statement).',
                false),
            pointedText(
                '2.',
                'Dengan menggunakan layanan e-Statement, maka Nasabah menyetujui bahwa mutasi transaksi rekening akan dikirimkan ke alamat e-mail yang telah terdaftar pada sistem Bank.',
                false),
            pointedText(
                '3.',
                'Nasabah bertanggung jawab terhadap adanya keterlambatan penerimaan, tidak diterimanya e-mail dan/atau kegagalan pengiriman e-mail yang disebabkan oleh kesalahan pemberian data alamat e-mail kepada Bank, perubahan alamat e-mail yang tidak diberitahukan kepada Bank, tidak dapat diaksesnya e-mail Nasabah karena suatu sebab (antara lain karena terblokir) dan kegagalan sistem Bank yang berada di luar kendali Bank.',
                false),
            pointedText(
                '4.',
                'Nasabah setuju bahwa Bank tidak berkewajiban untuk meneliti, menyelidiki keabsahan/kebenaran atas data alamat e-mail Nasabah dan/atau memastikan ketepatan telah diterimanya e-Statement oleh Nasabah. Karenanya Nasabah wajib menghubungi Bank apabila :',
                false),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '1.', 'e-Statement tidak diterima atau diterima namun tidak sempurna.', false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText('2.', 'Terdapat perubahan data alamat e-mail.', false),
            ),
            pointedText(
                '5.',
                'Dalam hal terdapat sanggahan atas segala sesuatu yang termuat dalam e-Statement tersebut harus dilakukan dalam waktu 30 (tiga puluh) hari kalender sejak e-Statement disampaikan atau dikirim oleh Bank kepada Nasabah. Bank berwenang untuk melakukan koreksi terhadap mutasi dan saldo rekening bila terjadi kekeliruan pembukuan oleh Bank.',
                false),
            pointedText(
                '6.',
                'Dalam hal e-Statement telah dikirimkan ke alamat email Nasabah namun gagal terkirim karena alamat email yang disampaikan nasabah salah yang terjadi selama 3 (tiga) bulan berturut-turut, maka Bank tidak akan mengirimkan kembali e-Statement tersebut.',
                false),
            pointedText(
                '7.',
                'Bagi Nasabah yang pengiriman Rekening Korannya dihentikan sebagaimana dimaksud butir B.6, maka Nasabah tersebut dapat meminta kepada Bank agar Rekening Korannya dikirimkan kembali setiap bulan dengan menyampaikan permohonan secara tertulis dan disampaikan secara langsung ke Cabang Pembuka Rekening.',
                false),
            Text(
              "C. Fasilitas Transaksi Perbankan Melalui Sarana Elektronik (e-Banking)",
              style: semibold14,
            ),
            SizedBox(
              height: 10,
            ),
            pointedText(
                '1.',
                'Bank menyediakan fasilitas bagi Nasabah untuk dapat melakukan Transaksi perbankan melalui sarana elektronik (e-Banking), yaitu:',
                false),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '1.',
                  'BNI ATM dan derivatifnya (ATM Non Tunai, ATM Setoran Tunai) adalah fasilitas Transaksi perbankan 24 (dua puluh empat) jam melalui mesin ATM (Anjungan Tunai Mandiri).',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '2.',
                  'BNI Phone Banking adalah fasilitas Transaksi perbankan 24 (dua puluh empat) jam dengan memberikan perintah Transaksi kepada Bank melalui telepon.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '3.',
                  'BNI SMS Banking adalah salah satu fasilitas transaksi perbankan 24 (dua puluh empat) jam melalui fasilitas e-Banking dari BNI untuk mengakses rekening Nasabah melalui Telepon Selular yang dimilikinya (provider jaringan GSM dan CDMA) dengan cara mengirimkan SMS (Short Message Service) perintah dalam format tertentu ke nomor 3346. BNI SMS Banking juga dapat diakses melalui telepon seluler oleh Nasabah dengan mendownload aplikasinya terlebih dahulu.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '4.',
                  'BNI Internet Banking adalah salah satu fasilitas transaksi perbankan 24 (dua puluh empat) jam melalui fasilitas e-Banking dari BNI untuk mengakses rekening yang dimiliki Nasabah melalui jaringan internet dengan menggunakan perangkat lunak browser pada komputer dan telepon seluler.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '5.',
                  'BNI Mobile Banking adalah layanan e-Banking dari Bank yang dapat diakses melalui telepon seluler oleh Nasabah dengan men-download aplikasinya terlebih dahulu.',
                  false),
            ),
            pointedText(
                '2.',
                'Jenis Rekening simpanan perorangan yang dapat diberikan fasilitas e-Banking ditetapkan oleh Bank.',
                false),
            pointedText(
                '3.',
                'Untuk dapat menggunakan fasilitas e-Banking, Nasabah harus memiliki tanda pengguna dan nomor identifikasi pribadi fasilitas e-Banking, yaitu:',
                false),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '1.',
                  'BNI ATM berupa Kartu Debit BNI dan PIN (Personal Identification Number) dari Kartu Debit BNI yang digunakan untuk melakukan Transaksi perbankan melalui mesin ATM, baik melalui jaringan BNI ATM, jaringan ATM Link, jaringan ATM Bersama, jaringan ATM Cirrus dan jaringan ATM lainnya yang ditentukan oleh Bank. Kartu Debit BNI juga dapat digunakan untuk pembayaran Transaksi belanja pada merchant yang memasang logo MasterCard atau merchant lainnya yang ditentukan oleh Bank.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '2.',
                  'BNI Phone Banking berupa user id (berupa nomor BNI Debit Card) dan PIN BNI Phone Banking.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '3.',
                  'BNI SMS Banking berupa user id (berupa nomor telepon seluler) dan PIN BNI SMS Banking.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '4.',
                  'BNI Internet Banking berupa user id dan password BNI Internet Banking serta perangkat alat pengaman tambahan yaitu BNI e-Secure/m-Secure.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '5.',
                  'BNI Mobile Banking berupa user id, nomor telepon seluler, PIN BNI Mobile Banking dan password transaksi.',
                  false),
            ),
            pointedText(
                '4.',
                'Persyaratan dan tata cara pendaftaran serta pengaktifan fasilitas e-Banking ditetapkan oleh Bank mengacu pada dokumen persyaratan dan ketentuan registrasi masing-masing fasilitas e-Banking sebagaimana tertuang dalam Syarat dan Ketentuan Produk Elektronik Banking dan media resmi Bank.',
                false),
            pointedText(
                '5.',
                'Tanda pengguna dan nomor identifikasi pribadi fasilitas e-Banking merupakan alat otorisasi dan verifikasi bagi Bank untuk melaksanakan Transaksi yang diinstruksikan oleh Nasabah melalui fasilitas e-Banking.',
                false),
            pointedText(
                '6.',
                'Instruksi yang disampaikan oleh Nasabah menggunakan tanda pengguna dan nomor identifikasi pribadi fasilitas e-Banking mempunyai kekuatan hukum yang sama dengan perintah tertulis yang ditandatangani oleh Nasabah.',
                false),
            pointedText(
                '7.',
                'Tanda pengguna dan nomor identifikasi pribadi fasilitas e-Banking hanya diketahui dan menjadi rahasia pribadi Nasabah. Setiap penyalahgunaan tanda pengenal nomor identifikasi pribadi fasilitas e-Banking menjadi tanggung jawab dan resiko Nasabah sepenuhnya.',
                false),
            pointedText(
                '8.',
                'Untuk Transaksi yang diinstruksikan melalui BNI Phone Banking, Bank berhak melakukan verifikasi dan identifikasi Nasabah sebelum menggunakan fasilitas tersebut berdasarkan tata cara yang ditentukan dari waktu ke waktu oleh Bank.',
                false),
            pointedText(
                '9.',
                'Semua Transaksi yang dilakukan melalui fasilitas e-Banking akan mendebet dan tercatat pada Rekening yang terdaftar pada fasilitas e-Banking.',
                false),
            pointedText(
                '10.',
                'Bank tidak berkewajiban melaksanakan instruksi dari Nasabah jika saldo di Rekening Nasabah tidak mencukupi.',
                false),
            pointedText(
                '11.',
                'Dokumen berupa catatan-catatan Transaksi, surat-surat serta dokumen-dokumen lain yang disimpan dan dipelihara oleh Bank secara tertulis di atas kertas atau media lain maupun rekaman yang dapat dilihat, dibaca ataupun didengar merupakan alat bukti yang sah dan lengkap atas Transaksi yang dilaksanakan Nasabah melalui fasilitas e-Banking.',
                false),
            pointedText(
                '12.',
                'Jenis Transaksi perbankan yang dapat dilakukan melalui fasilitas e-Banking ditentukan oleh Bank sebagaimana tertuang dalam Syarat dan Ketentuan Produk Elektronik Banking dan media resmi Bank. Perubahan atas jenis Transaksi dimaksud akan diberitahukan kepada nasabah dari waktu ke waktu melalui media resmi Bank.',
                false),
            pointedText(
                '13.',
                'Setiap Transaksi melalui fasilitas e-Banking dibatasi nominal dan frekuensinya dengan suatu nominal dan frekuensi maksimum per transaksi dan/atau per hari yang ditentukan oleh Bank atau karena sebab lain yang ditentukan oleh Bank sebagaimana tertuang dalam Syarat dan Ketentuan Produk Elektronik Banking dan media resmi Bank.',
                false),
            pointedText(
                '14.',
                'Untuk setiap Transaksi yang dilakukan melalui fasilitas e-Banking, Nasabah akan dibebankan biaya dan tarif sesuai dengan ketentuan yang berlaku di Bank sebagaimana yang tertuang dalam Syarat dan Ketentuan Produk Elektronik Banking dan media resmi Bank.',
                false),
            pointedText(
                '15.',
                'Nasabah wajib memastikan bahwa perangkat komputer dan/atau telepon seluler yang digunakan untuk mengakses BNI e-Banking, bebas dari semua jenis virus atau bentuk aplikasi-aplikasi lainnya yang dapat merugikan Nasabah.',
                false),
            pointedText(
                '16.',
                'Bank sewaktu-waktu dan/atau setiap saat berhak menghentikan setiap fasilitas Elektronik Banking yang diperoleh Nasabah jika Nasabah tidak memenuhi/melanggar ketentuan/kebijakan yang telah ditetapkan oleh Bank sebagaimana tertuang dalam Syarat dan Ketentuan Produk Elektronik Banking dan media resmi Bank dan atau perundang-undangan yang berlaku, atas hal tersebut bank akan menginformasikan penghentian dimaksud kepada Nasabah dalam bentuk dan sarana apapun.',
                false),
            Text(
              "D. Fasilitas Pembayaran Tagihan dan Transfer Otomatis",
              style: semibold14,
            ),
            SizedBox(
              height: 10,
            ),
            pointedText(
                '1.',
                'Nasabah memberi kuasa kepada Bank untuk melaksanakan pembayaran tagihan (telepon/listrik/telepon pasca bayar/kartu kredit, dll) senilai tagihan atau nilai tagihan yang ditentukan oleh penyedia jasa. Kuasa tersebut berlaku terus menerus sejak ditandatanganinya Formulir Pembukaan Rekening dan berakhir pada saat Rekening ditutup, tidak tersedianya dana pada Rekening Nasabah selama 3 periode pembayaran berturut-turut, nomor tagihan salah/tidak ditemukan pada sistem penyedia jasa, atau apabila kuasa tersebut diakhiri oleh Nasabah sebagaimana dimaksud dalam butir VII.F.4 ini.',
                false),
            pointedText(
                '2.',
                'Nasabah bertanggung jawab sepenuhnya atas pemutusan hubungan telepon/listrik/telepon pasca bayar/kartu kredit atau risiko lainnya sebagai akibat tidak dapat dilakukannya pembayaran tagihan atau transfer otomatis karena tidak cukupnya dana pada Rekening Nasabah, Bank belum menerima nilai tagihan yang harus dibayarkan dari penyedia jasa atau akibat kegagalan sistem.',
                false),
            pointedText(
                '3.',
                'Untuk setiap Transaksi pembayaran tagihan dan transfer otomatis, Nasabah akan dibebankan biaya yang tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '4.',
                'Bila Nasabah bermaksud menghentikan fasilitas pembayaran tagihan atau transfer otomatis, maka Nasabah wajib memberitahukan secara tertulis kepada Bank. Apabila Nasabah menggunakan fasilitas Phone Banking maka Nasabah dapat menghubungi BNI Call untuk mengajukan pemberhentian paling lambat 7 (tujuh) hari kerja sebelum dimulainya masa pembayaran fasilitas yang bersangkutan.\n',
                false),
            Text(
              "VIII. Rekening Tidak Aktif, Pemblokiran dan Penutupan Rekening\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Untuk kepentingan perlindungan Nasabah dan simpanannya, Bank atas pertimbangannya sendiri berhak melakukan pemblokiran fasilitas e-Banking tanpa persetujuan Nasabah terlebih dahulu.',
                false),
            pointedText(
                '2.',
                'Bank berhak memblokir dan/atau menutup Rekening apabila terdapat dugaan penyalahgunaan Rekening dan/atau pembukaan/penggunaan Rekening serta data/informasi/dokumen pendukung terkait Rekening yang tidak sesuai dengan ketentuan perundang-undangan yang berlaku.',
                false),
            pointedText(
                '3.',
                'Dalam hal Rekening Tabungan selama 6 (enam) bulan berturut-turut maupun untuk periode lain yang ditetapkan tidak bermutasi debet maupun kredit selain pendebetan dan pengkreditan yang dilakukan oleh sistem Bank untuk biaya administrasi, pajak, denda dan bunga, maka Rekening Tabungan akan diberi status tidak aktif. Perubahan periode untuk rekening yang diberi status tidak aktif akan diberitahukan oleh Bank kepada Nasabah dalam media resmi Bank.',
                false),
            pointedText(
                '4.',
                'Rekening dengan status tidak aktif dikenakan biaya yang besarnya tertuang dalam media resmi Bank.',
                false),
            pointedText(
                '5.',
                'Rekening dengan status tidak aktif dapat berubah menjadi Rekening aktif kembali apabila Nasabah melakukan transaksi atas Rekening tersebut baik transaksi setoran, penarikan dan pemindahbukuan melalui Kantor Cabang Bank.',
                false),
            pointedText(
                '6.',
                'Bank berhak secara otomatis menutup Rekening Tabungan yang berstatus tidak aktif sebagaimana dimaksud butir VIII.3 di atas dan bersaldo Rp. 0,- (saldo nihil) maupun untuk jumlah saldo tertentu yang dari waktu ke waktu akan diberitahukan oleh Bank kepada Nasabah melalui media resmi Bank.',
                false),
            pointedText(
                '7.',
                'Bank berhak dan berwenang untuk melakukan pemblokiran dan atau penutupan rekening apabila diduga nasabah berbentuk Shell Bank atau Bank yang mengizinkan rekeningnya digunakan oleh Shell Bank. Dalam hal ini yang dimaksud dengan Shell Bank adalah bank yang tidak mempunyai kehadiran secara fisik di wilayah hukum Bank tersebut didirikan dan memperoleh izin, dan tidak berafiliasi dengan kelompok usaha jasa keuangan yang menjadi subyek pengawasan terkonsolidasi yang efektif.\n',
                false),
            Text(
              "IX. Lain-lain\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Media Resmi Bank adalah sarana penyampaian informasi dari Bank kepada Nasabah berupa website/SMS/BNI Call/Surat/Pengumuman di Kantor Cabang Bank/Publikasi resmi di media massa.',
                false),
            pointedText(
                '2.',
                'Dana yang tersedia dalam Rekening Nasabah dijamin dalam program penjaminan yang diselenggarakan Lembaga Penjamin Simpanan (LPS) sesuai dengan syarat dan ketentuan yang ditetapkan oleh LPS.',
                false),
            pointedText(
                '3.',
                'Perjanjian ini telah disesuaikan dengan Ketentuan Peraturan Perundang-undangan termasuk Ketentuan Peraturan Otoritas Jasa Keuangan.',
                false),
            pointedText(
                '4.',
                'Bank tidak bertanggung jawab atas terjadinya hal-hal diluar kekuasaan Bank (Force Majeure).',
                false),
            pointedText(
                '5.',
                'Bank berwenang melakukan koreksi mutasi dan saldo Rekening Nasabah apabila terjadi kekeliruan pembukuan oleh Bank tanpa berkewajiban memberitahukan alasannya kepada Nasabah.',
                false),
            pointedText(
                '6.',
                'Dalam hal salah satu ketentuan dalam Perjanjian ini dinyatakan batal berdasarkan suatu peraturan perundang-undangan, maka pernyataan batal tersebut tidak mengurangi keabsahan atau menyebabkan batalnya persyaratan atau ketentuan lain dalam Perjanjian ini dan oleh karenanya ketentuan lain dalam Perjanjian ini tetap sah dan mengikat.\n',
                false),
            Text(
              "X. Pemberlakuan Ketentuan\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Bank berhak mengubah Ketentuan Umum dan Persyaratan Pembukaan Rekening ini termasuk ketentuan dan syarat-syarat yang berkaitan dengan produk/fasilitas/jasa yang secara khusus ditetapkan Bank yang menjadi satu kesatuan dan bagian yang tidak terpisahkan dari Ketentuan Umum dan Persyaratan Pembukaan Rekening ini yang akan diinformasikan melalui media resmi Bank sesuai dengan jangka waktu pemberitahuan yang ditetapkan oleh Otoritas Jasa Keuangan.',
                false),
            pointedText(
                '2.',
                'Syarat dan ketentuan produk/fasilitas/jasa selengkapnya diatur dalam syarat dan ketentuan masing-masing produk/fasilitas/jasa yang secara khusus ditetapkan oleh Bank meliputi Buku Petunjuk dan Kebijakan Internal Bank lainnya yang merupakan satu kesatuan serta bagian yang tidak terpisahkan dari Ketentuan Umum dan Persyaratan Pembukaan Rekening ini.',
                false),
            pointedText(
                '3.',
                'Dalam hal Ketentuan Umum dan Persyaratan Pembukaan Rekening ini bertentangan dengan ketentuan khusus pada masing-masing produk/fasilitas/jasa yang ditetapkan Bank, maka yang berlaku adalah ketentuan khusus dimaksud.\n',
                false),
            Text(
              "XI.	Hukum Yang Berlaku Dan Domisili\n",
              style: semibold14,
            ),
            pointedText(
                '1.',
                'Ketentuan Umum dan Persyaratan Pembukaan Rekening ini serta pelaksanaannya lebih lanjut tunduk pada hukum negara Republik Indonesia.',
                false),
            pointedText(
                '2.',
                'Bank dan Nasabah dengan ini sepakat bahwa segala gugatan akan diajukan di Pengadilan Negeri di wilayah hukum dimana Kantor Cabang BNI pembuka Rekening Nasabah berada.',
                false),
            pointedText(
                '3.',
                'Penundukan pada domisili tersebut di atas tidak membatasi hak Bank untuk mengajukan gugatan terhadap Nasabah dalam domisili lainnya dalam wilayah Indonesia maupun luar Indonesia.\n',
                false),
            Text(
              "XII. Pernyataan Dan Persetujuan Nasabah\n",
              style: semibold14,
            ),
            Text(
              "Dengan menyetujui aplikasi ini, saya menyatakan bahwa:",
              style: infoStyle,
            ),
            pointedText(
                '1.',
                'Data Nasabah Perorangan yang diisikan pada Pembukaan Rekening Perorangan ini adalah yang sebenar-benarnya, apabila di kemudian hari terdapat perubahan atas data isian saya tersebut yang tidak saya sampaikan kepada BNI maka saya bertanggung jawab atas segala tuntutan, gugatan dan/atau klaim dari pihak manapun serta dari segala kerugian dan risiko yang mungkin timbul di kemudian hari.',
                false),
            pointedText(
                '2.',
                'Bank dapat melakukan pemeriksaan terhadap kebenaran data yang saya berikan dalam pembukaan rekening perorangan ini.',
                false),
            pointedText(
                '3.',
                'Bank telah memberikan penjelasan yang cukup mengenai karakteristik produk/fasilitas/jasa yang akan yang akan saya manfaatkan dan saya telah mengerti serta memahami segala konsekuensi pemanfaatan produk/fasilitas/jasa Bank, termasuk manfaat, resiko dan biaya-biaya yang melekat pada produk/fasilitas/jasa tersebut.',
                false),
            pointedText(
                '4.',
                'Bank dapat menginformasikan kepada saya mengenai peningkatan fasilitas dan/atau nilai tambah terhadap penggunaan produk dan/atau layanan BNI yang sudah saya miliki, maupun penawaran produk, program, dan layanan baru yang belum saya miliki melalui media, telepon, sms, email dan media lainnya (elektronik maupun non elektronik).',
                false),
            pointedText(
                '5.',
                'Saya memberi hak dan wewenang kepada Bank untuk melakukan pemblokiran dan atau penutupan rekening, apabila :',
                false),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '1.',
                  'Saya tidak mematuhi ketentuan Prinsip Mengenal Nasabah (Know Your Customer).',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '2.',
                  'Dokumen yang saya berikan kepada Bank diketahui dan/atau patut diduga palsu.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '3.',
                  'Informasi yang saya sampaikan kepada Bank tidak benar atau diragukan kebenarannya.',
                  false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: pointedText(
                  '4.',
                  'Memiliki sumber dana transaksi yang diketahui dan/atau patut diduga berasal dari hasil tindak pidana.',
                  false),
            ),
            pointedText(
                '6.',
                'Saya memberikan persetujuan kepada Bank untuk memberikan identitas saya kepada pihak lain meliputi anak perusahaan dan perusahaan yang bekerjasama dengan Bank didalam pengembangan produk/layanan/jasa Bank untuk tujuan komersial dan saya telah memahami penjelasaan Bank mengenai tujuan dan konsekuensi dari pemberian identitas tersebut.',
                false),
            pointedText(
                '7.',
                'Dalam rangka memenuhi ketentuan Peraturan Pemerintah Republik Indonesia tentang Besaran Nilai Simpanan yang Dijamin Lembaga Penjamin Simpanan (LPS), saya menyatakan setuju dan bersedia menerima resiko bahwa klaim penjaminan atas simpanan tidak akan dibayar apabila simpanan yang saya tempatkan di PT. Bank Negara Indonesia (Persero) Tbk tidak memenuhi ketentuan penjaminan simpanan, atau dinyatakan sebagai Klaim Penjaminan tidak layak dibayar sebagaimana yang telah ditetapkan oleh LPS.',
                false),
            pointedText(
                '8.',
                'Dalam hal pihak nasabah pemilik rekening dan pemberi dana dari nasabah pemilik rekening telah memenuhi persyaratan sebagai wajib pajak dan/atau telah memiliki NPWP maka saya menyatakan akan segera menyerahkan NPWP tersebut kepada BNI. Apabila dikemudian hari saya memiliki NPWP atau telah memenuhi persyaratan sebagai Wajib Pajak sesuai dengan ketentuan Peraturan Perundang-undangan yang berlaku, maka saya akan menyerahkan NPWP tersebut kepada BNI.',
                false),
            pointedText(
                '9.',
                'Saya memberi persetujuan kepada Bank untuk melengkapi dan melakukan pengkinian data (up-date data) berdasarkan data terakhir pada formulir/aplikasi produk dan layanan perbankan, apabila ternyata data yang telah Saya berikan dalam Formulir Pembukaan Rekening ini sudah tidak merupakan data yang terkini lagi.\n',
                false),
            Text(
              "Dengan menyetujui Formulir Ketentuan Umum dan Persyaratan Pembukaan Rekening ini, saya/kami menyatakan dengan ini menerima dan setuju mengikatkan diri pada semua syarat dan ketentuan umum yang tertuang dalam Formulir ini.",
              style: infoStyle,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pointedText(
                '',
                'Bank dapat menginformasikan kepada saya mengenai peningkatan fasilitas dan/atau nilai tambah terhadap penggunaan produk dan/atau layanan BNI yang sudah saya miliki, maupun penawaran produk, program, dan layanan baru yang belum saya miliki melalui media, telepon, sms, email dan media lainnya (elektronik maupun non elektronik).',
                true),
            pointedText(
                '',
                'Bank dapat memberikan data identitas saya kepada pihak lain meliputi anak perusahaan dan perusahaan yang bekerjasama dengan Bank didalam pengembangan produk/layanan/jasa untuk tujuan komersial dan saya memahami penjelasan bank mengenai tujuan dan konsekuensi dari pemberian identitas tersebut.',
                true),
          ],
        ),
      );
    }
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
            : Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  huruf,
                  style: infoStyle,
                ),
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
                style: infoStyle,
              )
            ],
          ),
        ),
      ],
    );
  }
}
