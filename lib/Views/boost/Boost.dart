import 'package:dormant_bitcoin_seeker_flutter/Views/boost/boost_card.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class Boost extends StatefulWidget {
  const Boost({ Key? key }) : super(key: key);

  @override
  _BoostState createState() => _BoostState();
}

class _BoostState extends State<Boost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top:35),
        child: Column(
          children: const [
            BoostCard(title: "Increase wallet generation speed by 10 for 5 minutes", description: "", actionName: "WATCH AN AD",),
            BoostCard(title: "Increase boost time for 15 minutes", description: "", actionName: "WATCH AN AD",),
            BoostCard(title: "Title 2", description: "", actionName: "1.99 \$",),
            BoostCard(title: "Title 3", description: "", actionName: "3.99 \$",),
          ],
        ),
      ),
    );
  }
}