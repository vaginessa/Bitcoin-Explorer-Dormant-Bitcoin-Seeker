import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/boost_card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/stats_chart.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

class Boost extends StatefulWidget {
  const Boost({ Key? key }) : super(key: key);

  @override
  _BoostState createState() => _BoostState();
}

class _BoostState extends State<Boost> with SingleTickerProviderStateMixin {

  List<StatsChart> charts = [];

  @override
  void initState() {
    WalletStats.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    charts =  [
      StatsChart(chartType: ChartType.WPS, chartValue: getChartValue(ChartType.WPS),),
      StatsChart(chartType: ChartType.BPS, chartValue: getChartValue(ChartType.BPS),),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(  
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:24, top:44),
                    child: Text("Current stats", style: TextStyle(color: Colors.white, fontSize: 27.5),),
                  ),
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: charts,
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BoostCard(title: "Increase WPS by 1 for 5 minutes", description: "", actionName: "WATCH AN AD",onBoost: onBoost,boostType: BoostType.WPS_ADS,),
                    BoostCard(title: "Increase BPS by 0.5 for 5 minutes", description: "", actionName: "WATCH AN AD",onBoost: onBoost,boostType: BoostType.BPS_ADS,),
                    BoostCard(title: "Increase WPS by 5 for ever", description: "", actionName: "0.99\$",onBoost: onBoost,boostType: BoostType.WPS_ADS,),
                    BoostCard(title: "Increase BPS by 2.5 for ever", description: "", actionName: "0.99\$",onBoost: onBoost,boostType: BoostType.BPS_ADS,),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  double getChartValue(ChartType chartType){
    switch(chartType){
      case ChartType.WPS :
        return WalletStats.walletsPerSecond;
      case ChartType.BPS :
        return WalletStats.brainwalletsPerSeconds;
      default :
        return 0;
    }
  }

  void onBoost(BoostType boostType){

    WalletStats.setData();

    switch(boostType){
      case BoostType.WPS_ADS :
        setState(() {
          WalletStats.walletsPerSecond += 1;
        });
        return;
      case BoostType.BPS_ADS :
        setState(() {
          WalletStats.brainwalletsPerSeconds += 0.5;
        });
        return;
      case BoostType.WPS_PREMIUM : 
        setState(() {
          WalletStats.brainwalletsPerSeconds += 5;
        });
        return;
      case BoostType.BPS_PREMIUM : 
        setState(() {
          WalletStats.brainwalletsPerSeconds += 2.5;
        });
        return;
    }
  }
}