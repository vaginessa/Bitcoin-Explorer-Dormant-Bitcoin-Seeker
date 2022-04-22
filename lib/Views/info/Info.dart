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
          Paragraph(text: "As of July 2020, there were over 10m bitcoins (\$85b) accumulated in dormant bitcoin addresses with no outgoing transactions at all in 2019 (Coindesk and Medium).", bottomMargin: 30),
          Paragraph(text: "The reason for this inactivity is probably that the holders of those bitcoins have just lost their private key and cannot gain access to their funds.", bottomMargin: 30),
          Paragraph(text: "A big part of this accumulated bitcoin will never leave the addresses where they are right now.", bottomMargin: 30),
          Paragraph(text: "Or maybe not! This app gives you the possibility to search for them by generating random private keys of bitcoin addresses and giving you the balance of those in real time.", bottomMargin: 30),
          Paragraph(text: "There is also the possibility to generate 12 phrase wallets (brainwallets).", bottomMargin: 30),
          Paragraph(text: "You can also search for Bitcoin wallets by their private key, public key, or address (if you search by public key or address, you can't calculate the private key).", bottomMargin: 30),
          Paragraph(text: "Once you have generated a Bitcoin wallet, you can check the balance of it directly from this app, or you can watch it directly from the Bitcoin blockchain.", bottomMargin: 30)
        ],
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph({ Key? key, required this.text, required this.bottomMargin }) : super(key: key);

  final String text;
  final int bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Center(child: Text(text, style: const TextStyle(color : Colors.white, fontSize: 15),textAlign: TextAlign.center)),
      const SizedBox(height:30)
      ],
    );
  }
}
