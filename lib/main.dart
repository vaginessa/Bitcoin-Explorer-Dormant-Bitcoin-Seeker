import 'dart:ui';
import 'package:dormant_bitcoin_seeker_flutter/Views/search/search.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:dormant_bitcoin_seeker_flutter/google_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Views/boost/boost.dart';
import 'Views/home/home.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize().then((value) => {
  //   print("Mobile Ads Initialized")
  // });
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  List<Widget> pages = [const Home(), const Boost(), const Search(), const Home()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: navbarBackgroundColor,
          currentIndex: pageIndex,
          unselectedItemColor: unfocusIconColor,
          selectedItemColor: focusIconColor,
          onTap: onChangePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", tooltip: ""),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Boost", tooltip: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search", tooltip: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings", tooltip: "")
          ],
        ),
      )
    );
  }

  void onChangePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
