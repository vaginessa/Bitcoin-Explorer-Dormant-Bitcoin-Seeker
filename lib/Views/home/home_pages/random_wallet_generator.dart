import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/bitcoin_wallet_card.dart';
import 'package:flutter/material.dart';

class RandomWalletGenerator extends StatefulWidget {
  const RandomWalletGenerator({ Key? key , required this.wallets }) : super(key: key);

  final List<BitcoinWalletCard> wallets;

  @override
  _RandomWalletGeneratorState createState() => _RandomWalletGeneratorState();
}

class _RandomWalletGeneratorState extends State<RandomWalletGenerator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Random wallet generator", style: TextStyle(color:Colors.white, fontSize: 20),),
              Column(
                children: widget.wallets,
              )
            ]
          )
        ],
      ),
    );
  }
}