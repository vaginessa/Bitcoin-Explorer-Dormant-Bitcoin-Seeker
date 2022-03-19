import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class ActiveBoostCard extends StatefulWidget {
  const ActiveBoostCard({ Key? key }) : super(key: key);

  @override
  State<ActiveBoostCard> createState() => _ActiveBoostCardState();
}

class _ActiveBoostCardState extends State<ActiveBoostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            width: 1
          )
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left : 30, right : 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("WPS", style: TextStyle(color: Colors.white, fontSize: 20),),
            Text("+ 10", style: TextStyle(color: Colors.white, fontSize: 17.5),),
            Text("5:00", style: TextStyle(color: Colors.yellow, fontSize: 17.5),),
          ],
        ),
      ),
    );
  }
}