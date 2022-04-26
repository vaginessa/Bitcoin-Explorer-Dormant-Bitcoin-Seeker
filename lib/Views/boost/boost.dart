import 'dart:async';

import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats_utils.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/active_boosts.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/boost_card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/stats_chart.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:dormant_bitcoin_seeker_flutter/google_admob.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Boost extends StatefulWidget {
  const Boost({ Key? key }) : super(key: key);

  @override
  _BoostState createState() => _BoostState();
}

class _BoostState extends State<Boost> with SingleTickerProviderStateMixin {

  List<StatsChart> charts = [];
  Timer? intervalCheck;

  /// IAP VARIABLES ///
  final String wpsID = "wps";
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _avaiable = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription? _subscription = null;
  int _credits = 0;
  ////////////////////
  
  /// IAP METHODS ///
  void _initialize() async {
    _avaiable = await _iap.isAvailable();

    if(_avaiable){
      await _getProducts();

      _verifyPurchase();

      _subscription = _iap.purchaseStream.listen((data) => setState(() {
        print("NEW PURCHASE");
        _purchases = data;
        _verifyPurchase();
      }));
    }
  }

  Future<void> _getProducts() async{
    Set<String> ids = Set.from([wpsID]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    _products = response.productDetails;
    print(_products);
  }

  PurchaseDetails _hasPurchased(String productID){
    return _purchases.firstWhere((purchase) => purchase.productID == productID);
  }

  void _verifyPurchase() {
    PurchaseDetails purchase = _hasPurchased(wpsID);

    if(purchase.status == PurchaseStatus.purchased){
      print("purchased");
    }
  }

  void _buyProduct(ProductDetails prod){
    final PurchaseParam purchaseParam = PurchaseParam(productDetails : prod);
    _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  void initState() {
    _initialize();
    super.initState();
    WalletStats.boostsCheck();

    WalletStats.getData().then((value) => {
      setState(() {
        
      })
    });

    intervalCheck = Timer.periodic(const Duration(seconds: 10), (timer) {
      if(WalletStats.boostsCheck()){
        setState(() {});
      }
    });
  }

  @override
  @mustCallSuper
  @protected
  void dispose() {
    _subscription?.cancel();
    intervalCheck?.cancel();
    super.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => const ActiveBoosts()
                              )
                            ).whenComplete(() => {
                                setState(() {
                                  
                                })
                            });
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
                    BoostCard(title: WalletStatsUtils.getButtonDescription(BoostType.WPS_ADS), description: "", actionName: WalletStatsUtils.getButtonTitle(BoostType.WPS_ADS),onBoost: onBoost,boostType: BoostType.WPS_ADS,),
                    BoostCard(title: WalletStatsUtils.getButtonDescription(BoostType.BPS_ADS), description: "", actionName: WalletStatsUtils.getButtonTitle(BoostType.BPS_ADS),onBoost: onBoost,boostType: BoostType.BPS_ADS,),
                    BoostCard(title: WalletStatsUtils.getButtonDescription(BoostType.WPS_PREMIUM), description: "", actionName: WalletStatsUtils.getButtonTitle(BoostType.WPS_PREMIUM),onBoost: onBoost,boostType: BoostType.WPS_PREMIUM,),
                    BoostCard(title: WalletStatsUtils.getButtonDescription(BoostType.BPS_PREMIUM), description: "", actionName: WalletStatsUtils.getButtonTitle(BoostType.BPS_PREMIUM),onBoost: onBoost,boostType: BoostType.BPS_PREMIUM,),
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

  Timer? timer;
  Timer? timer2;
  bool busy = false;
  void onBoost(BoostType boostType){
    switch(boostType){
      case BoostType.WPS_ADS :
        if(busy) return;
        busy = true;
        GoogleAdMob.showInterstitial();

        timer = Timer.periodic(
          const Duration(seconds: 1),
          (Timer timer) {
            if(GoogleAdMob.adResponse == false){
              GoogleAdMob.adResponse = null;
              timer.cancel();
              busy = false;
            }
            else if(GoogleAdMob.adResponse == true){

              setState(() {
                WalletStats.activateBoost(boostType);
                WalletStats.walletsPerSecond += WalletStatsUtils.getValue(boostType);
                WalletStats.checkMaxValues();
                WalletStats.setData();
              });

              GoogleAdMob.adResponse = null;
              timer.cancel();
              busy = false;
            }
          },
        );
        return;
      case BoostType.BPS_ADS :
        if(busy) return;
        busy = true;
        GoogleAdMob.showInterstitial();

        timer2 = Timer.periodic(
          const Duration(seconds: 1),
          (Timer timer) {
            if(GoogleAdMob.adResponse == false){
              GoogleAdMob.adResponse = null;
              timer.cancel();
              busy = false;
            }
            else if(GoogleAdMob.adResponse == true){

              setState(() {
                WalletStats.activateBoost(boostType);
                WalletStats.brainwalletsPerSeconds += WalletStatsUtils.getValue(boostType);
                WalletStats.checkMaxValues();
                WalletStats.setData();
              });

              GoogleAdMob.adResponse = null;
              timer.cancel();
              busy = false;
            }
          },
        );
        return;
      case BoostType.WPS_PREMIUM : 
        _buyProduct(_products.firstWhere((element) => element.id == wpsID));

        setState(() {
          WalletStats.walletsPerSecond += WalletStatsUtils.getValue(boostType);
          WalletStats.checkMaxValues();
          WalletStats.setData();
        });
        return;
      case BoostType.BPS_PREMIUM : 
        setState(() {
          WalletStats.brainwalletsPerSeconds += WalletStatsUtils.getValue(boostType);
          WalletStats.checkMaxValues();
          WalletStats.setData();
        });
        return;
    }
  }
}