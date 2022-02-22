// ignore_for_file: import_of_legacy_library_into_null_safe, implementation_imports, library_prefixes
import 'dart:typed_data';
import 'package:bitbox/bitbox.dart' as Bitbox;
import 'package:bip39/src/bip39_base.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';

class Bitcoin {
  static BitcoinWallet generateWallet() {
    Bitbox.ECPair keyPair = Bitbox.ECPair.makeRandom(compressed: true);

    return BitcoinWallet(
        privateKey: hex.encode(keyPair.privateKey),
        publicKey: hex.encode(keyPair.publicKey),
        address: keyPair.address);
  }

  static List<BitcoinWallet> generateWallets(int totalWallets) {
    List<BitcoinWallet> response = [];
    Bitbox.ECPair keyPair;

    for (int i = 0; i < totalWallets; i++) {
      keyPair = Bitbox.ECPair.makeRandom(compressed: true);

      response.add(BitcoinWallet(
          privateKey: hex.encode(keyPair.privateKey),
          publicKey: hex.encode(keyPair.publicKey),
          address: keyPair.address
        )
      );
    }

    return response;
  }

  static BitcoinWallet generateBrainWallet() {
    String phrases = generateMnemonic();
    Uint8List seed = mnemonicToSeed(phrases);

    Uint8List newSeed = Uint8List.sublistView(seed, 0, 32);
    Bitbox.ECPair keyPair = Bitbox.ECPair.fromPrivateKey(newSeed, compressed:true);

    return BitcoinWallet(
      seed: phrases,
      privateKey: hex.encode(keyPair.privateKey),
      publicKey: hex.encode(keyPair.publicKey),
      address: keyPair.address
    );
  }

  static BitcoinWallet getWalletFromPrivateKey(String privateKey) {
    Bitbox.ECPair keyPair = Bitbox.ECPair.fromWIF(privateKey);

    return BitcoinWallet(
        privateKey: hex.encode(keyPair.privateKey),
        publicKey: hex.encode(keyPair.publicKey),
        address: keyPair.address);
  }

  static String generateMnemonic({int strength = 128}) =>
      bip39.generateMnemonic(strength: strength);
  static Uint8List mnemonicToSeed(String mnemonic) =>
      bip39.mnemonicToSeed(mnemonic);
}
