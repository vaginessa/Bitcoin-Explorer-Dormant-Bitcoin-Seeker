// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const double DEFAULT_WPS = 1;
const double DEFAULT_BPS = 1;

class WalletStats{
  static double walletsPerSecond = DEFAULT_WPS;
  static double brainwalletsPerSeconds = DEFAULT_BPS;

  Map toMap(){
    return {
      "WPS" : walletsPerSecond,
      "BPS" : brainwalletsPerSeconds
    };
  }

  static void setData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();    
    sharedPreferences.setDouble("WPS", walletsPerSecond);
    sharedPreferences.setDouble("BPS", brainwalletsPerSeconds);
  }

  static void getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    walletsPerSecond = sharedPreferences.getDouble("WPS") as double;
    brainwalletsPerSeconds = sharedPreferences.getDouble("BPS") as double;
  }
}