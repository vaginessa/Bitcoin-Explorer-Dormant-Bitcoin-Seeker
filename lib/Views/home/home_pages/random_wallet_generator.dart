import 'package:flutter/material.dart';

class RandomWalletGenerator extends StatefulWidget {
  const RandomWalletGenerator({ Key? key }) : super(key: key);

  @override
  _RandomWalletGeneratorState createState() => _RandomWalletGeneratorState();
}

class _RandomWalletGeneratorState extends State<RandomWalletGenerator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("Random wallet generator", style: TextStyle(color:Colors.white, fontSize: 20),)
            ]
          )
        ],
      ),
    );
  }
}