// ignore_for_file: import_of_legacy_library_into_null_safe, implementation_imports
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import "package:pointycastle/ecc/curves/secp256k1.dart";
import 'package:pointycastle/ecc/api.dart' show ECPoint;
import "package:pointycastle/digests/sha256.dart";
import 'package:pointycastle/src/utils.dart';
import 'package:bs58check/bs58check.dart' as bs58check;
import "package:pointycastle/digests/ripemd160.dart";
import '../Shared/bitcoin_wallet_card.dart';
import 'package:bip39/src/bip39_base.dart' as bip39;

class BitcoinLib{

  final Random rd = Random();
  final secp256k1 = ECCurve_secp256k1();
  final Network network = Network.bitcoinCash();

  void generateWallet(SendPort sendPort) async{ 
    Uint8List privateKey;
    Uint8List publicKey;
    String address;
    List<BitcoinWallet> wallets = [];
    BitcoinWallet wallet;
    BitcoinWalletCard card;

    while(true){
      //Private key
      privateKey = randomPrivateKey();

      //Public key
      publicKey = privateKeyToPublicKey(privateKey, true);

      //Address
      address = publicKeyToAddress(hash160(publicKey), network.pubKeyHash);

      //Wallet
      wallet = BitcoinWallet(
        privateKey: hex.encode(privateKey),
        publicKey: hex.encode(publicKey),
        address: address
      );

      wallets.add(wallet);

      card = BitcoinWalletCard(wallet: wallet);
      // wallet.request();
      WalletGeneratorState.wallets.add(card);
      sendPort.send(card);

      await Future.delayed(const Duration(milliseconds: 500 ));
    }
  }

  void generateBrainWallet(SendPort sendPort) async{ 
    Uint8List privateKey;
    Uint8List publicKey;
    String address;
    BitcoinWallet wallet;
    BitcoinWalletCard card;

    while(true){
      String phrases = generateMnemonic();

      //Private key
      privateKey = mnemonicToSeed(phrases);

      //Public key
      publicKey = privateKeyToPublicKey(privateKey, true);

      //Address
      address = publicKeyToAddress(hash160(publicKey), network.pubKeyHash);

      //Wallet
      wallet = BitcoinWallet(
        seed: phrases,
        privateKey: hex.encode(privateKey),
        publicKey: hex.encode(publicKey),
        address: address
      );

      card = BitcoinWalletCard(wallet: wallet);
      // wallet.request();
      WalletGeneratorState.brainWallets.add(card);
      sendPort.send(card);

      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void searchByAddress(Map<String,Object> params) async{
    //Wallet
    BitcoinWallet wallet = BitcoinWallet(
      address: params["address"] as String
    );

    bool isValid = await wallet.request();

    if(isValid){
      BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
      WalletGeneratorState.searchResultByAddress = card;
      (params["sendPort"] as SendPort).send(card);
    }
    else{
      (params["sendPort"] as SendPort).send(null);
    }
  }

  void searchByPrivateKey(Map<String,Object> params) async{
    Uint8List privateKey = Uint8List(0);
    try{
      privateKey = Uint8List.fromList(hex.decode(params["privateKey"] as String));
    }
    on Exception {
      (params["sendPort"] as SendPort).send(null);
      return;
    }

    Uint8List publicKey = privateKeyToPublicKey(privateKey, true);
    String address = publicKeyToAddress(hash160(publicKey), network.pubKeyHash);
    BitcoinWallet wallet = BitcoinWallet(
        privateKey: hex.encode(privateKey),
        publicKey: hex.encode(publicKey),
        address: address
      );
    BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
    WalletGeneratorState.searchResultByPrivateKey = card;

    bool isValid = await wallet.request();

    if(isValid){
      BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
      WalletGeneratorState.searchResultByPrivateKey = card;
      (params["sendPort"] as SendPort).send(card);
    }
    else{
      (params["sendPort"] as SendPort).send(null);
    }
  }

  void searchBySeedPhrase(Map<String,Object> params) async{
    String phrases = params["seedPhrase"] as String;
    Uint8List privateKey = mnemonicToSeed(phrases);
    Uint8List publicKey = privateKeyToPublicKey(privateKey, true);
    String address = publicKeyToAddress(hash160(publicKey), network.pubKeyHash);
    BitcoinWallet wallet = BitcoinWallet(
      seed: phrases,
      privateKey: hex.encode(privateKey),
      publicKey: hex.encode(publicKey),
      address: address
    );
    BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
    WalletGeneratorState.searchResultBySeedPhrase = card;

    bool isValid = await wallet.request();

    if(isValid){
      BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
      WalletGeneratorState.searchResultByPrivateKey = card;
      (params["sendPort"] as SendPort).send(card);
    }
    else{
      (params["sendPort"] as SendPort).send(null);
    }
  }

  // UTILITIES
  Uint8List randomPrivateKey(){
    List<int> bytes = List.generate(32, (index) => rd.nextInt(256));
    return Uint8List.fromList(bytes);
  }

  Uint8List privateKeyToPublicKey(Uint8List privateKey, bool _compressed) {
    BigInt dd = fromBuffer(privateKey);
    ECPoint pp = secp256k1.G * dd;
    // if (pp.isInfinity) return null;
    return getEncoded(pp, _compressed);
  }

  String publicKeyToAddress(Uint8List hash, int version) {
    Uint8List payload = Uint8List(21);
    payload[0] = version;
    payload.setRange(1, payload.length, hash);
    return bs58check.encode(payload);
  }

  Uint8List hash160(Uint8List buffer) {
    Uint8List _tmp = SHA256Digest().process(buffer);
    return RIPEMD160Digest().process(_tmp);
  }

  Uint8List getEncoded(ECPoint P, compressed) { return P.getEncoded(compressed); }
  BigInt fromBuffer(Uint8List d) { return decodeBigInt(d); }

  String generateMnemonic({int strength = 128}) => bip39.generateMnemonic(strength: strength);
  Uint8List mnemonicToSeed(String mnemonic) => bip39.mnemonicToSeed(mnemonic);
}

class Network {
  static const bchPrivate = 0x80;
  static const bchTestnetPrivate = 0xef;

  static const bchPublic = 0x00;
  static const bchTestnetPublic = 0x6f;

  final int bip32Private;
  final int bip32Public;
  final bool testnet;
  final int pubKeyHash;
  final int private;
  final int public;

  Network(this.bip32Private, this.bip32Public, this.testnet, this.pubKeyHash,
      this.private, this.public);

  factory Network.bitcoinCash() => Network(0x0488ade4, 0x0488b21e, false, 0x00, bchPrivate, bchPublic);
  factory Network.bitcoinCashTest() => Network(0x04358394, 0x043587cf, true, 0x6f, bchTestnetPrivate, bchTestnetPublic);

  String get prefix => testnet ? "bchtest" : "bitcoincash";
}