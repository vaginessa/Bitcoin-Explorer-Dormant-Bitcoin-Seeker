// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dormant_bitcoin_seeker_flutter/Models/active_boost.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats_utils.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/boost/active_boost_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double DEFAULT_WPS = 1;
const double DEFAULT_BPS = 1;
const double MAX_WPS = 1000;
const double MAX_BPS = 1000;

class WalletStats {
  static double walletsPerSecond = DEFAULT_WPS;
  static double brainwalletsPerSeconds = DEFAULT_BPS;

  static List<ActiveBoost> activeBoosts = [];
  static List<ActiveBoostCard> activeBoostsCards = [];

  static void activateBoost(BoostType boostType) {
    DateTime endTime = DateTime.now();
    endTime = endTime.add(Duration(seconds: WalletStatsUtils.getSeconds(boostType)));

    ActiveBoost activeBoost = ActiveBoost(endTime: endTime.toString(), boostType: boostType);
    ActiveBoostCard activeBoostCard = ActiveBoostCard(boost: activeBoost);

    activeBoosts.add(activeBoost);
    activeBoostsCards.add(activeBoostCard);
  }

  static Future<void> setData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", walletsPerSecond);
    sharedPreferences.setDouble("BPS", brainwalletsPerSeconds);

    List<String> _activeBoosts = [];
    for (int n = 0; n < activeBoosts.length; n++) {
      _activeBoosts.add(jsonEncode(activeBoosts[n].toMap()));
    }

    sharedPreferences.setStringList("active boosts", _activeBoosts);
  }

  static Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dynamic _wps = sharedPreferences.getDouble("WPS");
    dynamic _bps = sharedPreferences.getDouble("BPS");
    List<String> _activeBoosts = sharedPreferences.getStringList("active boosts") as List<String>;

    walletsPerSecond = _wps == null ? DEFAULT_WPS : _wps as double;
    brainwalletsPerSeconds = _bps == null ? DEFAULT_BPS : _bps as double;

    activeBoosts = [];
    activeBoostsCards = [];

    for(int n=0;n<_activeBoosts.length;n++){
      Map<String, String> temp = Map.from(json.decode(_activeBoosts[n]));
      ActiveBoost _boost =ActiveBoost(endTime : temp["end time"]!, boostType: WalletStatsUtils.boostTypeConvert(null,temp["boost type"]!) as BoostType);
      activeBoosts.add(_boost);
      activeBoostsCards.add(ActiveBoostCard(boost: _boost));
    }
  }

  static Future<void> resetData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", DEFAULT_WPS);
    sharedPreferences.setDouble("BPS", DEFAULT_BPS);

    sharedPreferences.setStringList("active boosts", []);
  }

  static void removeBoost(ActiveBoost boost){
    int index = activeBoosts.indexOf(boost);
    activeBoosts.removeAt(index);
    activeBoostsCards.removeAt(index);

    if(boost.boostType == BoostType.WPS_ADS){
      walletsPerSecond -= WalletStatsUtils.getValue(boost.boostType);
    }
    else if(boost.boostType ==  BoostType.BPS_ADS){
      brainwalletsPerSeconds -= WalletStatsUtils.getValue(boost.boostType);
    }
  }

  static bool boostsCheck(){
    bool result = false;

    DateTime currentTime = DateTime.now();
    DateTime endTime;
    int seconds = 0;

    for(int n=0;n<activeBoosts.length;n++){
      endTime = DateTime.parse(activeBoosts[n].endTime);
      seconds = endTime.difference(currentTime).inSeconds;

      if(seconds < 1){
        removeBoost(activeBoosts[n]);
        result = true;
      }
    }

    return result;
  }

  static void checkMaxValues(){
    if(walletsPerSecond > MAX_WPS){
      walletsPerSecond = MAX_WPS;
    }
                                        
    if(brainwalletsPerSeconds > MAX_BPS){
      brainwalletsPerSeconds = MAX_BPS;  
    }  
  }
}
