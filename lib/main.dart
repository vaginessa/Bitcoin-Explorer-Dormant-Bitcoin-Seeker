import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';

import 'Views/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: const Home(),
        bottomNavigationBar: BottomNavigationBar(
          type : BottomNavigationBarType.fixed,
          backgroundColor: navbarBackgroundColor,
          currentIndex: pageIndex,
          unselectedItemColor: unfocusIconColor,
          selectedItemColor: focusIconColor,
          items: const [
            BottomNavigationBarItem(icon: Icon (Icons.home), label: "Home",tooltip: ""),
            BottomNavigationBarItem(icon: Icon (Icons.trending_up_sharp), label: "Market",tooltip: ""),
            BottomNavigationBarItem(icon: Icon (Icons.history), label: "History",tooltip: ""),
            BottomNavigationBarItem(icon: Icon (Icons.settings), label: "Settings",tooltip: "")
          ],
        ),
      )
    );
  }

  void onChangePage(int index){
    setState(() {
      pageIndex = index;
    });
  }
}