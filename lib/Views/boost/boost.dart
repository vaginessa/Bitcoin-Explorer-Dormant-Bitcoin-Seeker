import 'dart:async';
import 'dart:developer';
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats_utils.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/boost_card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/stats_chart.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Boost extends StatefulWidget {
  const Boost({Key? key}) : super(key: key);

  @override
  _BoostState createState() => _BoostState();
}

class _BoostState extends State<Boost> with SingleTickerProviderStateMixin {
  List<StatsChart> charts = [];
  Timer? intervalCheck;

  /// IAP VARIABLES ///
  final String wpsID = "wps";
  final String bpsID = "bps";
  final InAppPurchase iapInstance = InAppPurchase.instance;
  bool avaiable = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription? _subscription;
  ////////////////////

  /// IAP METHODS ///
  void initIAP() async {
    avaiable = await iapInstance.isAvailable();

    if (avaiable) {
      // Get Google Play Products
      ProductDetailsResponse response = await iapInstance.queryProductDetails({wpsID, bpsID});
      _products = response.productDetails;
    }
  }

  void verifyPurchase(String id) {
    PurchaseDetails purchase =
        _purchases.firstWhere((purchase) => purchase.productID == id);

    if (purchase.status == PurchaseStatus.purchased) {
      if (id == wpsID) {
        setState(() {
          if (WalletStats.walletsPerSecond + WalletStatsUtils.getValue(BoostType.WPS_PREMIUM) > MAX_WPS) 
          {
            WalletStats.walletsPerSecond = MAX_WPS;
          } else 
          {
            WalletStats.walletsPerSecond += WalletStatsUtils.getValue(BoostType.WPS_PREMIUM);
          }

          WalletStats.setData();
        });
      } else if (id == bpsID) {
        setState(() {
          if (WalletStats.brainwalletsPerSeconds + WalletStatsUtils.getValue(BoostType.BPS_PREMIUM) > MAX_BPS) 
          {
            WalletStats.brainwalletsPerSeconds = MAX_BPS;
          } else 
          {
            WalletStats.brainwalletsPerSeconds += WalletStatsUtils.getValue(BoostType.BPS_PREMIUM);
          }

          WalletStats.setData();
        });
      }
    }
  }

  void _buyProduct(ProductDetails prod) async {
    log("OPENED PAYMENT WINDOW");
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    await iapInstance.buyConsumable(purchaseParam: purchaseParam);

    // Subscribe to the google play purchase stream
    _subscription ??= iapInstance.purchaseStream.listen((data) => setState(() {
          print("NEW PURCHASE");
          _purchases = data;
          verifyPurchase(prod.id);
        }
      )
    );
  }

  @override
  void initState() {
    initIAP();
    super.initState();
    WalletStats.boostsCheck();

    // Get wps, bps, active boots
    WalletStats.getData().then((value) => {setState(() {})});

    //Check if an active boost is finished
    intervalCheck = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (WalletStats.boostsCheck()) {
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
    charts = [
      StatsChart(
        chartType: ChartType.WPS,
        chartValue: getChartValue(ChartType.WPS),
      ),
      StatsChart(
        chartType: ChartType.BPS,
        chartValue: getChartValue(ChartType.BPS),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color.fromRGBO(18, 18, 18, 1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 24, top: 44, right: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Current stats", style: TextStyle(color: Colors.white, fontSize: 27.5),),
                            ])),
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
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
                )),
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
                  BoostCard(
                    title: WalletStatsUtils.getButtonDescription(
                        BoostType.WPS_PREMIUM),
                    description: "",
                    actionName:
                        WalletStatsUtils.getButtonTitle(BoostType.WPS_PREMIUM),
                    onBoost: onBoost,
                    boostType: BoostType.WPS_PREMIUM,
                  ),
                  BoostCard(
                    title: WalletStatsUtils.getButtonDescription(
                        BoostType.BPS_PREMIUM),
                    description: "",
                    actionName:
                        WalletStatsUtils.getButtonTitle(BoostType.BPS_PREMIUM),
                    onBoost: onBoost,
                    boostType: BoostType.BPS_PREMIUM,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  double getChartValue(ChartType chartType) {
    switch (chartType) {
      case ChartType.WPS:
        return WalletStats.walletsPerSecond;
      case ChartType.BPS:
        return WalletStats.brainwalletsPerSeconds;
      default:
        return 0;
    }
  }

  Timer? timer;
  Timer? timer2;
  bool busy = false;
  void onBoost(BoostType boostType) {
    switch (boostType) {
      case BoostType.WPS_PREMIUM:
        _buyProduct(_products.firstWhere((element) => element.id == wpsID));
        return;
      case BoostType.BPS_PREMIUM:
        _buyProduct(_products.firstWhere((element) => element.id == bpsID));
        return;
    }
  }
}
