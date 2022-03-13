import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import 'package:flutter/material.dart';
import '../../global.dart';

class BitcoinWalletDetail extends StatefulWidget {
  const BitcoinWalletDetail({ Key? key, required this.wallet }) : super(key: key);

  final BitcoinWallet wallet;

  @override
  _BitcoinWalletDetailState createState() => _BitcoinWalletDetailState();
}

class _BitcoinWalletDetailState extends State<BitcoinWalletDetail> {

  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitcoin Wallet", style : TextStyle(color:Colors.white)),
        backgroundColor: dialogAppBarBackgroundColor,
      ),
      body: Container(
        padding: dialogContentMargins,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: walletCardBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.wallet.balance.toString() + " BTC", style: const TextStyle(color: balanceColor, fontSize: 35, fontWeight: FontWeight.bold),),
            const SizedBox(height:20),
            if(widget.wallet.seed != null)
              KeyBanner(title : "12 phrases seed", content : widget.wallet.seed!),

            if(widget.wallet.privateKey != null)
              KeyBanner(title : "Private key", content : widget.wallet.privateKey!),

            if(widget.wallet.publicKey != null)
              KeyBanner(title : "Public key", content : widget.wallet.publicKey!),

            KeyBanner(title : "Address", content : widget.wallet.address),
          ],
        ),
      ),
    );
  }
}

class KeyBanner extends StatelessWidget {
  const KeyBanner({
    Key? key,
    required this.title,
    required this.content
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height:20),
        Text(title, style: const TextStyle(color:Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
        Container(
          padding: const EdgeInsets.only(top:8, bottom:8, left:16, right:16),
          margin:const EdgeInsets.only(top:8),
          width: double.infinity,
          height:50,
          decoration: const BoxDecoration(
            color :Color.fromARGB(255, 40, 96, 143),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content, style: const TextStyle(color:Color.fromRGBO(215, 215, 215, 1)),)
            ]
          ),
        )
      ],
    );
  }
}