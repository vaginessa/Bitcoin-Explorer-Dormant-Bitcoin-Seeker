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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top:35),
        child: Column(  
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 1)
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Current stats", style: TextStyle(color: Colors.white, fontSize: 27.5),),
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
                          children: const [
                            StatsChart(title : "Wallets per second"),
                            StatsChart(title : "Brainwallet per second"),
                            StatsChart(title : "Wallets boost"),
                            StatsChart(title : "Brainwallet boost"),
                          ],
                        ),
                      )
                    ),
                  ],
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
                      children: const [
                        BoostCard(title: "Increase wallet generation speed by 10 for 5 minutes", description: "", actionName: "WATCH AN AD",),
                        BoostCard(title: "Increase boost time for 15 minutes", description: "", actionName: "WATCH AN AD",),
                        BoostCard(title: "Title 2", description: "", actionName: "1.99 \$",),
                        BoostCard(title: "Title 3", description: "", actionName: "3.99 \$",),
                        BoostCard(title: "Title 3", description: "", actionName: "3.99 \$",),
                        BoostCard(title: "Title 3", description: "", actionName: "3.99 \$",),
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
}