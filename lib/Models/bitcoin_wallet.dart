import 'dart:convert';
import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/blockchain.dart';

class BitcoinWallet{
  String? seed;
  String? privateKey;
  String? publicKey;
  String address;
  double balance = 0;
  Map<String,dynamic> json = {};
  int? cardIndex;

  BitcoinWallet({
    this.seed,
    this.privateKey,
    this.publicKey,
    required this.address
  });

  Future<bool> request() async{
    bool result = false;
    await Blockchain.request(address).then((response) => {
        result = !(response.statusCode >= 400),
        if(result){
          json = jsonDecode(response.body),
          balance = json[address] != null ? (json[address]["final_balance"] as int).toDouble() : 0,
          result = json[address] != null,
          if(balance != 0)
            balance = balance / 10000000
        }
    });
    return result;
  }
}