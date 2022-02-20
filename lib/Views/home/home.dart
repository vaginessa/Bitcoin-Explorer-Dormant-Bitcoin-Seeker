import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/home/home_pages/random_wallet_generator.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: lateralContentMargins.right,),
                  const PreviewCard(icon: Icon(Icons.home), title: "Wallet generator", subtitle: "test description",),
                  const SizedBox(width: 30,),
                  const PreviewCard(icon: Icon(Icons.home), title: "Wallet generator", subtitle: "test description",),
                  const SizedBox(width:30),
                  const PreviewCard(icon: Icon(Icons.home), title: "Wallet generator", subtitle: "test description",)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:lateralContentMargins.left, right:lateralContentMargins.right,top:30),
              child: Column(
                children: [
                  RandomWalletGenerator(wallets: WalletGeneratorState.wallets,)
                ],
              ),
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        backgroundColor: isPlaying ? Colors.red : Colors.green,
        onPressed: () { 
          togglePlay();
        },
      ),
    );
  }

  bool isPlaying = false;
  void togglePlay(){
    setState(() {
      isPlaying = !isPlaying;
      WalletGeneratorState.generate();
    });
  }
}