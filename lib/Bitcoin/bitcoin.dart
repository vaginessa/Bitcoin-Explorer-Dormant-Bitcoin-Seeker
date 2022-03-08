// ignore_for_file: import_of_legacy_library_into_null_safe, implementation_imports, library_prefixes
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:bitbox/bitbox.dart' as Bitbox;
import 'package:bip39/src/bip39_base.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import 'package:flutter/foundation.dart';

class Bitcoin {
  static Random rd = Random();

  static Future<BitcoinWallet> generateWallet() async {
    Map map = Map();
    map["private key"] = randomPrivateKey();
    map["compressed"] = true;


    Bitbox.ECPair keyPair = await compute(computedGenerateWallet,map);

    return BitcoinWallet(
      privateKey: hex.encode(keyPair.privateKey),
      publicKey: /*hex.encode(keyPair.publicKey)*/ "",
      address: keyPair.address
    );
  }

  static Bitbox.ECPair computedGenerateWallet(dynamic map) {
    return Bitbox.ECPair.fromPrivateKey(map["private key"], compressed : map["compressed"]);
  }

  static BitcoinWallet generateBrainWallet() {
    String phrases = generateMnemonic();
    Uint8List seed = mnemonicToSeed(phrases);

    Uint8List newSeed = Uint8List.sublistView(seed, 0, 32);
    Bitbox.ECPair keyPair = Bitbox.ECPair.fromPrivateKey(newSeed, compressed:true);

    return BitcoinWallet(
      seed: phrases,
      privateKey: hex.encode(keyPair.privateKey),
      publicKey: /*hex.encode(keyPair.publicKey)*/ "",
      address: keyPair.address
    );
  }

  static BitcoinWallet getWalletFromPrivateKey(String privateKey) {
    Bitbox.ECPair keyPair = Bitbox.ECPair.fromWIF(privateKey);

    return BitcoinWallet(
      privateKey: hex.encode(keyPair.privateKey),
      publicKey: /*hex.encode(keyPair.publicKey)*/ "",
      address: keyPair.address
    );
  }

  static Uint8List randomPrivateKey(){
    List<int> bytes = List.generate(32, (index) => rd.nextInt(256));
    return Uint8List.fromList(bytes);
  }

  static String generateMnemonic({int strength = 128}) => bip39.generateMnemonic(strength: strength);
  static Uint8List mnemonicToSeed(String mnemonic) => bip39.mnemonicToSeed(mnemonic);
}
