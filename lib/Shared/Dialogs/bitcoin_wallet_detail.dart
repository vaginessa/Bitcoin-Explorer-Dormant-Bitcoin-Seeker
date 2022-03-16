import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import 'package:flutter/material.dart';
import '../../global.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: backgroundColor,
      ),
      body: Container(
        padding: dialogContentMargins,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: walletCardBackgroundNew,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Text(widget.wallet.balance.toString() + " BTC", style: const TextStyle(color: balanceColor, fontSize: 35, fontWeight: FontWeight.bold),),
                const SizedBox(height:50),
                if(widget.wallet.seed != null)
                  KeyBanner(title : "12 phrases seed", content : widget.wallet.seed!, onSeed: true,),

                if(widget.wallet.privateKey != null)
                  KeyBanner(title : "Private key", content : widget.wallet.privateKey!, onSeed: false,),

                if(widget.wallet.publicKey != null)
                  KeyBanner(title : "Public key", content : widget.wallet.publicKey!, onSeed: false,),

                KeyBanner(title : "Address", content : widget.wallet.address, onSeed: false,),
              ],
            ),
            SizedBox(
              height:60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  String url = "https://www.blockchain.com/btc/address/" + widget.wallet.address;
                  try{
                    await launch(url);
                  }
                  on Exception{
                    return;
                  }
                }, 
                child: const Text("VIEW ON BLOCKCHAIN", style: TextStyle(color: Colors.white, letterSpacing: 1, wordSpacing: 1),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 56, 56, 56)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),
            ),
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
    required this.content,
    required this.onSeed
  }) : super(key: key);

  final String title;
  final String content;
  final bool onSeed;

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
          decoration: const BoxDecoration(
            color :Color.fromARGB(255, 32, 32, 32),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content != "" || onSeed ? content : "Unknown", style: const TextStyle(color:Color.fromRGBO(215, 215, 215, 1)),)
            ]
          ),
        )
      ],
    );
  }
}