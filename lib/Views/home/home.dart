import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/home/home_pages/brainwallet_generator.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/home/home_pages/random_wallet_generator.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> content = [
    RandomWalletGenerator(wallets: WalletGeneratorState.wallets,),
    BrainwalletGenerator(wallets: WalletGeneratorState.wallets)
  ];

  int selectedContent = 0;

  @override
  Widget build(BuildContext context) {
    content = [
      RandomWalletGenerator(wallets: WalletGeneratorState.wallets,),
      BrainwalletGenerator(wallets: WalletGeneratorState.brainWallets)
    ];
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top:50),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: lateralContentMargins.right,),
                  GestureDetector(
                    child: const PreviewCard(icon: Icon(Icons.account_balance_wallet),title: "Random wallets", subtitle: "Standard Bitcoin wallet",),
                    onTap: (){
                      setState(() {
                        selectedContent = 0;
                      });
                    },
                  ),
                  const SizedBox(width:30),
                  GestureDetector(
                    child: const PreviewCard(icon: Icon(Icons.text_snippet), title: "12 Phrases", subtitle: "Brainwallet",),
                    onTap: (){
                      setState(() {
                        selectedContent = 1;
                      });
                    },
                  ),
                  const SizedBox(width:30),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:lateralContentMargins.left, right:lateralContentMargins.right,top:30),
              child: Column(
                children: [
                  content[selectedContent]
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
  void togglePlay() async{
    if(selectedContent == 0){
      await WalletGeneratorState.generate();
    }
    else if(selectedContent == 1){
      await WalletGeneratorState.generateBrainWallet();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }
}