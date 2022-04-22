import 'package:dormant_bitcoin_seeker_flutter/Models/bitcoin_wallet.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/Dialogs/bitcoin_wallet_detail.dart';
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
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          color: appBarBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        width:double.infinity,
        height:75,
        margin: const EdgeInsets.only(top:10),
        child: Padding(
          padding: const EdgeInsets.only(left:16, right:16),
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
                      if(widget.wallet.seed == null && widget.wallet.privateKey == null)
                        Text(widget.wallet.address,overflow: TextOverflow.ellipsis, style:const TextStyle(color:unfocusIconColor, fontSize: 17.5),)
                      else if(widget.wallet.seed != null || widget.wallet.privateKey != null)
                        ...[
                          Text(widget.wallet.seed != null ? widget.wallet.seed! : widget.wallet.privateKey!, overflow: TextOverflow.ellipsis, style: const TextStyle(color:unfocusIconColor, fontSize: 17.5),),
                          Text(widget.wallet.address,overflow: TextOverflow.ellipsis, style:const TextStyle(color:unfocusIconColor, fontSize: 12.5))
                        ]
                    ],
                  ),
                ),
              ),
              Text(widget.wallet.balance > 1 ? widget.wallet.balance.toStringAsFixed(2) + " BTC" : widget.wallet.balance.toString() + " BTC", style: const TextStyle(color:balanceColor, fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => BitcoinWalletDetail(wallet:widget.wallet)));
      },
    );
  }
}