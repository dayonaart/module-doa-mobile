import 'package:eform_modul/src/models/jenis-tabungan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesTabungan {
  Future saveTabungan(Tabungan tabungan, SharedPreferences preferences) async {
    // final preferences = await SharedPreferences.getInstance();

    preferences.setString('produk', tabungan.produk);
    preferences.setString('produkType', tabungan.produkType);
    preferences.setString('bin', tabungan.bin);
    preferences.setString('cardType', tabungan.cardType);
    preferences.setString('namaKartu', tabungan.namaKartu);

    List<String> _produkSplit = splitData(tabungan.produkType);
    preferences.setString('accountType', _produkSplit[0]);
    preferences.setString('subCat', _produkSplit[1]);
    print('Saved Tabungan');

    print("Produk Type" + _produkSplit.toString());
  }

  List<String> splitData(String text) {
    List<String> theText = text.split("-");
    List<String> textArray = [theText.removeAt(0), theText.join(":")];
    return textArray;
  }

  Future<Tabungan> getTabungan() async {
    final preferences = await SharedPreferences.getInstance();

    final produk = preferences.getString('produk');
    final produkType = preferences.getString('produkType');
    final bin = preferences.getString('bin');
    final cardType = preferences.getString('cardType');
    final namaKartu = preferences.getString('namaKartu');

    return Tabungan(produk!, produkType!, bin!, cardType!, namaKartu!);
  }
}
