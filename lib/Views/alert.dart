import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("New Version Avaiable!"),
      ),
      body: Container(
        width: double.infinity,
        color: caveColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Column(
                  children: const [
                    SizedBox(height: 30,),
                    FittedBox(child: Text("Dormant Bitcoin Explorer", style: TextStyle(color: Colors.white, fontSize: 25),)),
                    SizedBox(height: 40,),
                    FittedBox(
                      child: Text("News : ", style: TextStyle(color: Colors.white, fontSize: 20),)
                    ),
                    SizedBox(height: 20,),
                    FittedBox(
                      child: Text("- 12 Phrases / Brainwallet generation faster", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text("- Private keys generation faster", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text("- Improve response time", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text("- Search By brainwallet", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text("- Performance improvements", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text("- 24 phrases wallets support", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5), fontSize: 15),)
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              margin: const EdgeInsets.only(bottom:20),
              child: ElevatedButton(onPressed: (){
                launchUrl(
                  Uri.parse("market://details?id=com.BlockchainExplorer.DormantBitcoinExplorer"),
                  mode: LaunchMode.externalApplication,
                );
              }, child: const Text('DOWNLOAD NOW'))
            ),
          ],
        ),
      ),
    );
  }
}