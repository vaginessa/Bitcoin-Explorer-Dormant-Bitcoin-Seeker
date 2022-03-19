// ignore_for_file: constant_identifier_names

import 'package:dormant_bitcoin_seeker_flutter/Models/active_boost.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/active_boost_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double DEFAULT_WPS = 1;
const double DEFAULT_BPS = 1;
const double MAX_WPS = 1000;
const double MAX_BPS = 1000;

class WalletStats{
  static double walletsPerSecond = DEFAULT_WPS;
  static double brainwalletsPerSeconds = DEFAULT_BPS;
  
  static List<ActiveBoost> activeBoosts = [];
  static List<ActiveBoostCard> activeBoostsCards = [];

  static void activateBoost(BoostType boostType){
    ActiveBoost activeBoost = ActiveBoost(startTime: "", boostType: boostType);
    ActiveBoostCard activeBoostCard = ActiveBoostCard(boost : activeBoost);

    activeBoosts.add(activeBoost);
    activeBoostsCards.add(activeBoostCard);
  }

  static Future<void> setData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();                                      

    sharedPreferences.setDouble("WPS", walletsPerSecond);
    sharedPreferences.setDouble("BPS", brainwalletsPerSeconds);
  }

  static Future<void> getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    walletsPerSecond = sharedPreferences.getDouble("WPS") as double;
    brainwalletsPerSeconds = sharedPreferences.getDouble("BPS") as double;
  }

  static Future<void> resetData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", DEFAULT_WPS);
    sharedPreferences.setDouble("BPS", DEFAULT_BPS);
  }
}