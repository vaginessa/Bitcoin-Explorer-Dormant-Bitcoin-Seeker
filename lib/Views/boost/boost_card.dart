import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class BoostCard extends StatefulWidget {
  const BoostCard({ 
    Key? key, 
    required this.title, 
    required this.description,
    required this.actionName
  }) : super(key: key);

  final String title;
  final String description;
  final String actionName;

  @override
  State<BoostCard> createState() => _BoostCardState();
}

class _BoostCardState extends State<BoostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.only(left:lateralContentMargins.left, right:lateralContentMargins.right,top:15),
      decoration: const BoxDecoration(
        color: boostCardBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right:15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16),),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: Text(widget.actionName, style: const TextStyle(color: Colors.white, letterSpacing: 1),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple)
              ),
            )
          ],
        ),
      ),
    );
  }
}