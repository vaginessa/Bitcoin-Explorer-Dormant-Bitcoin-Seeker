// ignore_for_file: import_of_legacy_library_into_null_safe, implementation_imports, library_prefixes
import 'dart:typed_data';
import 'package:bitbox/bitbox.dart' as Bitbox;
import 'package:bip39/src/bip39_base.dart' as bip39;
import 'package:convert/convert.dart';

class Bitcoin{
  static Map<String,String> generateWallet(){
    Bitbox.ECPair keyPair = Bitbox.ECPair.makeRandom(compressed: true);

    return {
      "private key" : hex.encode(keyPair.privateKey),
      "public key" : hex.encode(keyPair.publicKey),
      "address" : keyPair.address
    };
  }

  static List<Map<String,String>> generateWallets(int totalWallets){

    List<Map<String,String>> response = [];

    Bitbox.ECPair keyPair;

    for(int i=0;i<totalWallets;i++){
      keyPair = Bitbox.ECPair.makeRandom(compressed: true);

      response.add({
        "private key" : hex.encode(keyPair.privateKey),
        "public key" : hex.encode(keyPair.publicKey),
        "address" : keyPair.address
      });
    }

    return response;
  }

  static String generateMnemonic({int strength = 128}) => bip39.generateMnemonic(strength: strength);
  static Uint8List mnemonicToSeed(String mnemonic) => bip39.mnemonicToSeed(mnemonic);
}