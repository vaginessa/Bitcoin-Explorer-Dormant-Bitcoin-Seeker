import 'dart:async';

import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats_utils.dart';
import 'package:flutter/material.dart';

import '../../Models/active_boost.dart';

class ActiveBoostCard extends StatefulWidget {
  const ActiveBoostCard({ 
    Key? key,
    required this.boost
  }) : super(key: key);

  final ActiveBoost boost;

  @override
  State<ActiveBoostCard> createState() => _ActiveBoostCardState();
}

class _ActiveBoostCardState extends State<ActiveBoostCard> {

  Timer? timer;
  int time = 300;
  bool hide = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time < 1) {
          setState(() {
            WalletStats.removeBoost(widget.boost);
            WalletStats.setData();
            timer.cancel();
            hide = true;
          });
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    
    DateTime currentTime = DateTime.now();
    DateTime endTime = DateTime.parse(widget.boost.endTime);

    int seconds = endTime.difference(currentTime).inSeconds;

    if(seconds < 1){
      WalletStats.removeBoost(widget.boost);
      WalletStats.setData();
    }
    else{
      time = seconds;
      startTimer();
    }

    setState(() {});
  }

  @mustCallSuper
  @protected
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !hide ? Container(
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
          children: [
            Text(widget.boost.boostType == BoostType.WPS_ADS ? "WPS" : "BPS", style: const TextStyle(color: Colors.white, fontSize: 20),),
            Text("+ " + WalletStatsUtils.getValue(widget.boost.boostType).toString(), style: const TextStyle(color: Colors.white, fontSize: 17.5),),
            Text(formatTime(time), style: const TextStyle(color: Colors.yellow, fontSize: 17.5),),
          ],
        ),
      ),
    ) : const Center();
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
}