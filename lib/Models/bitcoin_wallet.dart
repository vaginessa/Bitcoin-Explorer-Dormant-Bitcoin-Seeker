import 'dart:convert';
import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/blockchain.dart';

class BitcoinWallet{
  String? seed;
  String privateKey;
  String publicKey;
  String address;
  int balance = 0;
  Map<String,dynamic> json = {};
  int? cardIndex;

  BitcoinWallet({
    this.seed,
    required this.privateKey,
    required this.publicKey,
    required this.address
  });

  Future<void> request() async{
    // await Blockchain.request(address).then((response) => {
    //   json = jsonDecode(response.body),
    //   balance = json[address]["final_balance"],
    // });
  }
}