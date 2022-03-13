import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {

  int walletGenerationSpeed = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:20),
      child: CircularPercentIndicator(
        header: Container(
          width:200,
          margin: const EdgeInsets.only(bottom:20),
          child: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18),textAlign: TextAlign.center,)
        ),
        radius: 75.0,
        lineWidth: 10.0,
        animation: true,
        percent: walletGenerationSpeed/100,
        center: Text(
          walletGenerationSpeed.toString(),
          style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        backgroundColor: Colors.grey,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: balanceColor,
      ),
    );
  }
}