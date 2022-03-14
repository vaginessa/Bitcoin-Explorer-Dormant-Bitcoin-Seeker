import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsChart extends StatefulWidget {
  const StatsChart({ 
    Key? key,
    required this.chartType,
    required this.chartValue
  }) : super(key: key);

  final int chartValue;
  final ChartType chartType;

  @override
  State<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:20),
      child: CircularPercentIndicator(
        header: Container(
          width:200,
          margin: const EdgeInsets.only(bottom:20),
          child: Text(getChartTitle(), style: const TextStyle(color: Colors.white, fontSize: 18),textAlign: TextAlign.center,)
        ),
        radius: 75.0,
        lineWidth: 10.0,
        animation: true,
        percent: widget.chartValue/100,
        center: Text(
          widget.chartValue.toString(),
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.grey,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: balanceColor,
      ),
    );
  }

  void refresh(){
    setState(() {
      
    });
  }

  String getChartTitle(){
    switch(widget.chartType){
      case ChartType.WALLETS_PER_SECOND :
        return "Wallets per second";
      case ChartType.BRAINWALLETS_PER_SECONDS :
        return "Brainwallet per second";
      default :
        return "";
    }
  }
}