// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dormant_bitcoin_seeker_flutter/Models/active_boost.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
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
    DateTime startTime = DateTime.now();
    // final berlinWallFell = DateTime.utc(1989, 11, 9);
    // final moonLanding = DateTime.parse('1969-07-20 20:18:04Z'); // 8:18pm

    ActiveBoost activeBoost =
        ActiveBoost(startTime: startTime.toString(), boostType: boostType);
    ActiveBoostCard activeBoostCard = ActiveBoostCard(boost: activeBoost);

    print(activeBoost.startTime);

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
    dynamic _activeBoosts = sharedPreferences.getStringList("active boosts");

    walletsPerSecond = _wps == null ? DEFAULT_WPS : _wps as double;
    brainwalletsPerSeconds = _bps == null ? DEFAULT_BPS : _bps as double;

    print(_activeBoosts);
  }

  static Future<void> resetData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", DEFAULT_WPS);
    sharedPreferences.setDouble("BPS", DEFAULT_BPS);
  }
}
