import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:flutter/material.dart';

import '../../global.dart';
import 'active_boost_card.dart';

class ActiveBoosts extends StatefulWidget {
  const ActiveBoosts({ Key? key }) : super(key: key);

  @override
  State<ActiveBoosts> createState() => _ActiveBoostsState();
}

class _ActiveBoostsState extends State<ActiveBoosts> {

  List<ActiveBoostCard> activeBoosts = [];

  @override
  Widget build(BuildContext context) {

    activeBoosts = WalletStats.activeBoosts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text("Active boosts", style: TextStyle(color : Colors.white),),
      ),
      backgroundColor: backgroundColor,
      body: activeBoosts.isEmpty ? const Center(
        child: Text("EMPTY", style: TextStyle(color : Colors.white, fontSize: 20))
      ) :         
      NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: activeBoosts,
          ),
        ),
      )
    );
  }
}