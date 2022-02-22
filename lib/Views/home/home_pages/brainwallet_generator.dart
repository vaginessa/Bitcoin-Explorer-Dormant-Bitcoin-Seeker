import 'package:flutter/material.dart';

import '../../../Shared/bitcoin_wallet_card.dart';

class BrainwalletGenerator extends StatefulWidget {
  const BrainwalletGenerator({ Key? key, required this.wallets }) : super(key: key);

    final List<BitcoinWalletCard> wallets;

  @override
  _BrainwalletGeneratorState createState() => _BrainwalletGeneratorState();
}

class _BrainwalletGeneratorState extends State<BrainwalletGenerator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Brainwallet generator", style: TextStyle(color:Colors.white, fontSize: 20),textAlign:TextAlign.left ,),
          Column(
            children: widget.wallets,
          )
        ]
      ),
    );
  }
}