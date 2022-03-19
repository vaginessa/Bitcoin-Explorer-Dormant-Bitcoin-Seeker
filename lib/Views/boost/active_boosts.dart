import 'package:flutter/material.dart';

import '../../global.dart';

class ActiveBoosts extends StatefulWidget {
  const ActiveBoosts({ Key? key }) : super(key: key);

  @override
  State<ActiveBoosts> createState() => _ActiveBoostsState();
}

class _ActiveBoostsState extends State<ActiveBoosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text("Active boosts", style: TextStyle(color : Colors.white),),
      ),
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text("EMPTY", style: TextStyle(color : Colors.white, fontSize: 20),),
      ),
    );
  }
}