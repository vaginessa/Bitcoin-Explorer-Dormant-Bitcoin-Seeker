// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

const double DEFAULT_WPS = 1;
const double DEFAULT_BPS = 1;
const double MAX_WPS = 200.0;
const double MAX_BPS = 100.0;

class WalletStats {
  static double walletsPerSecond = DEFAULT_WPS;
  static double brainwalletsPerSeconds = DEFAULT_BPS;

  static Future<void> setData() async {
    WalletStats.checkMaxValues();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", walletsPerSecond);
    sharedPreferences.setDouble("BPS", brainwalletsPerSeconds);
  }

  static Future<void> getData() async {
    // WalletStats.resetData();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dynamic _wps = sharedPreferences.getDouble("WPS");
    dynamic _bps = sharedPreferences.getDouble("BPS");

    walletsPerSecond = _wps == null ? DEFAULT_WPS : _wps as double;
    brainwalletsPerSeconds = _bps == null ? DEFAULT_BPS : _bps as double;
  }

  static Future<void> resetData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble("WPS", DEFAULT_WPS);
    sharedPreferences.setDouble("BPS", DEFAULT_BPS);
  }

  static bool boostsCheck() {
    bool result = false;

    setData();

    return result;
  }

  static void checkMaxValues() {
    if (walletsPerSecond > MAX_WPS) {
      walletsPerSecond = MAX_WPS;
    }

    if (brainwalletsPerSeconds > MAX_BPS) {
      brainwalletsPerSeconds = MAX_BPS;
    }
  }
}
