import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/active_boosts.dart';
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
    super.initState();
    WalletStats.getData().then((value) => {
      setState(() {
        
      })
    });

    // WalletStats.resetData().then((value) => {
    //   setState(() {

    //   })
    // });
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
                  Padding(
                    padding: const EdgeInsets.only(left:24, top:44, right : 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        const Text("Current stats", style: TextStyle(color: Colors.white, fontSize: 27.5),),
                        GestureDetector(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 68, 39, 2),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(Icons.show_chart_sharp, color: Colors.orange,size : 30),
                            )
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveBoosts()));
                          },
                        )
                      ]
                    )
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
                    BoostCard(title: "Increase WPS by 5 for ever", description: "", actionName: "0.99\$",onBoost: onBoost,boostType: BoostType.WPS_PREMIUM,),
                    BoostCard(title: "Increase BPS by 2.5 for ever", description: "", actionName: "0.99\$",onBoost: onBoost,boostType: BoostType.BPS_PREMIUM,),
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
    switch(boostType){
      case BoostType.WPS_ADS :
        setState(() {
          WalletStats.walletsPerSecond += 1;

          checkMaxValues();

          WalletStats.setData();
        });
        return;
      case BoostType.BPS_ADS :
        setState(() {
          WalletStats.brainwalletsPerSeconds += 0.5;

          checkMaxValues();

          WalletStats.setData();
        });
        return;
      case BoostType.WPS_PREMIUM : 
        setState(() {

          WalletStats.activateBoost();

          WalletStats.walletsPerSecond += 5;

          checkMaxValues();

          WalletStats.setData();
        });
        return;
      case BoostType.BPS_PREMIUM : 
        setState(() {

          WalletStats.activateBoost();

          WalletStats.brainwalletsPerSeconds += 2.5;

          checkMaxValues();

          WalletStats.setData();
        });
        return;
    }
  }

  void checkMaxValues(){
    if(WalletStats.walletsPerSecond > MAX_WPS){
      WalletStats.walletsPerSecond = MAX_WPS;
    }
                                        
    if(WalletStats.brainwalletsPerSeconds > MAX_BPS){
      WalletStats.brainwalletsPerSeconds = MAX_BPS;  
    }  
  }
}