import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class BoostCard extends StatelessWidget {
  const BoostCard({ Key? key }) : super(key: key);

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Title", style: TextStyle(color: Colors.white, fontSize: 20),),
                Text("description", style: TextStyle(color: descriptionColor, fontSize: 15),),
              ],
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("BUY", style: TextStyle(color: Colors.white, letterSpacing: 1),),
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