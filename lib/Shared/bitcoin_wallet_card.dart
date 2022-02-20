import 'dart:ui';

import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class BitcoinWalletCard extends StatefulWidget {
  const BitcoinWalletCard({ Key? key, required this.wallet}) : super(key: key);

  final BitcoinWallet wallet;

  @override
  _BitcoinWalletCardState createState() => _BitcoinWalletCardState();
}

class _BitcoinWalletCardState extends State<BitcoinWalletCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient:LinearGradient(colors: [
          Color.fromARGB(255, 8, 66, 114), 
          Color.fromARGB(255, 40, 96, 143)
        ]),
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      width:double.infinity,
      height:75,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right:48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.wallet.privateKey,overflow: TextOverflow.ellipsis, style: const TextStyle(color:unfocusIconColor, fontSize: 17.5),),
                    Text(widget.wallet.address, style:const TextStyle(color:unfocusIconColor, fontSize: 12.5),),
                  ],
                ),
              ),
            ),
            const Text("0 BTC", style: TextStyle(color:focusIconColor, fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}