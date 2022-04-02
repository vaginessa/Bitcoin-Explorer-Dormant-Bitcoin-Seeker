import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:60, right:20,left:20),
      child: Column(
        children: const [
          Center(child: Text("Dormant Bitcoin Seeker", style : TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color : Colors.orange))),
          SizedBox(height:30),
          Center(child: Text("It has been estimated that there are more than 3 million bitcoins lost forever... or maybe not forever! This app gives you the possibility to search for them by generating random private keys of bitcoin addresses and giving you the balance of those in real time.", style: TextStyle(color : Colors.white, fontSize: 15),textAlign: TextAlign.center,),),
          SizedBox(height:30),
          Center(child: Text("There is also the possibility to generate 12 phrase wallets (brainwallets).", style: TextStyle(color : Colors.white, fontSize: 15),textAlign: TextAlign.center,),),
          SizedBox(height:30),
          Center(child: Text("You can also search for Bitcoin wallets by their private key, public key, or address (if you search by public key or address, you can't calculate the private key).", style: TextStyle(color : Colors.white, fontSize: 15),textAlign: TextAlign.center,),),
          SizedBox(height:30),
          Center(child: Text("Once you have generated a Bitcoin wallet, you can check the balance of it directly from this app, or you can watch it directly from the Bitcoin blockchain.", style: TextStyle(color : Colors.white, fontSize: 15),textAlign: TextAlign.center,),),
        ],
      ),
    );
  }
}
