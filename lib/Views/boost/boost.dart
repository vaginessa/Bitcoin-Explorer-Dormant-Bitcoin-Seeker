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

class _BoostState extends State<Boost> {

  List<StatsChart> charts = [];

  @override
  Widget build(BuildContext context) {

    charts =  [
      StatsChart(chartType: ChartType.WALLETS_PER_SECOND, chartValue: getChartValue(ChartType.WALLETS_PER_SECOND),),
      StatsChart(chartType: ChartType.BRAINWALLETS_PER_SECONDS, chartValue: getChartValue(ChartType.BRAINWALLETS_PER_SECONDS),),
      StatsChart(chartType: ChartType.WALLETS_PER_SECOND, chartValue: getChartValue(ChartType.WALLETS_PER_SECOND),),
      StatsChart(chartType: ChartType.BRAINWALLETS_PER_SECONDS, chartValue: getChartValue(ChartType.WALLETS_PER_SECOND),),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(  
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(18, 18, 18, 1)
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin : const EdgeInsets.only(top:20),
                        child: const Text("Current stats", style: TextStyle(color: Colors.white, fontSize: 27.5),)
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
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom:10),
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  double getChartValue(ChartType chartType){
    switch(chartType){
      case ChartType.WALLETS_PER_SECOND :
        return WalletStats.walletsPerSecond;
      case ChartType.BRAINWALLETS_PER_SECONDS :
        return WalletStats.brainwalletsPerSeconds;
      default :
        return 0;
    }
  }

  void onBoost(BoostType boostType){
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
    }
  }
}