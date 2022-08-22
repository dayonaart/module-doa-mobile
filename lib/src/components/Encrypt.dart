import 'package:encrypt/encrypt.dart';
// import 'package:encryptrsa/interop/ffi_bridge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/pointycastle.dart';

class Encrypt {
  // var rsaPublicKey = FFIBridge();

  String encrypt(String pin) {
    RSAKeyParser keyParser = RSAKeyParser();
    RSAAsymmetricKey publicKeyParser = keyParser.parse("rsaPublicKey.loadRSA()");
    final publicKey = RSAPublicKey(publicKeyParser.modulus!, publicKeyParser.exponent!);
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    final encrypted = encrypter.encrypt(pin);
    if (kDebugMode) {
      print(encrypted.base64);
    }
    String result = encrypted.base64;
    return result;
  }
}

// class Encrypt {
//   Future<RSAPublicKey?> loadRSA() async {
//     try {
//       return RSAKeyParser().parse(await rootBundle.loadString('assets/doa.pem'))
//           as RSAPublicKey;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<String?> encrypt(String pin) async {
//     RSAKeyParser keyParser = RSAKeyParser();
//     var _rsa = await loadRSA();
//     if (_rsa == null) {
//       return null;
//     }
//     final encrypter = Encrypter(RSA(publicKey: _rsa));

//     final encrypted = encrypter.encrypt(pin);
//     return encrypted.base64;
//   }
// }
// }
// class Encrypt {
//   Future<RSAPublicKey?> loadRSA() async {
//     try {
//       return RSAKeyParser().parse(await rootBundle.loadString('assets/doa.pem'))
//           as RSAPublicKey;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<String?> encrypt(String pin) async {
//     RSAKeyParser keyParser = RSAKeyParser();
//     var _rsa = await loadRSA();
//     if (_rsa == null) {
//       return null;
//     }
//     final encrypter = Encrypter(RSA(publicKey: _rsa));

//     final encrypted = encrypter.encrypt(pin);
//     return encrypted.base64;
//   }
// }
