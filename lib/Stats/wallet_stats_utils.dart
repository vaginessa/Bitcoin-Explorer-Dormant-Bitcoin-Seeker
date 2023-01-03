// ignore_for_file: constant_identifier_names
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';

const double WPS_PREMIUM = 5;
const double BPS_PREMIUM = 2.5;
const double WPS_PREMIUM_2 = 10;
const double WPS_PREMIUM_3 = 17;

const String WPS_PREMIUM_BUTTON_DESCRIPTION = "Increase WPS by 5 for ever";
const String BPS_PREMIUM_BUTTON_DESCRIPTION = "Increase BPS by 2.5 for ever";
const String WPS_PREMIUM_2_BUTTON_DESCRIPTION = "Increase WPS by 10 for ever";
const String WPS_PREMIUM_3_BUTTON_DESCRIPTION = "Increase WPS by 17 for ever";

const String WPS_PREMIUM_BUTTON_TITLE = "5.99\$";
const String BPS_PREMIUM_BUTTON_TITLE = "5.99\$";
const String WPS_2_PREMIUM_BUTTON_TITLE = "10.99\$";
const String WPS_3_PREMIUM_BUTTON_TITLE = "15.99\$";

const String WPS_CHART_TITLE = "Wallets per second\n(WPS)";
const String BPS_CHART_TITLE = "Wallets per second\n(WPS)";

class WalletStatsUtils {
  static String getButtonTitle(BoostType boostType) {
    switch (boostType) {
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM_BUTTON_TITLE;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM_BUTTON_TITLE;
      case BoostType.WPS_PREMIUM_2:
        return WPS_2_PREMIUM_BUTTON_TITLE;
      case BoostType.WPS_PREMIUM_3:
        return WPS_3_PREMIUM_BUTTON_TITLE;
    }
  }

  static String getButtonDescription(BoostType boostType) {
    switch (boostType) {
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM_BUTTON_DESCRIPTION;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM_BUTTON_DESCRIPTION;
      case BoostType.WPS_PREMIUM_2:
        return WPS_PREMIUM_2_BUTTON_DESCRIPTION;
      case BoostType.WPS_PREMIUM_3:
        return WPS_PREMIUM_3_BUTTON_DESCRIPTION;
    }
  }

  static String getChartTitle(ChartType chartType) {
    switch (chartType) {
      case ChartType.WPS:
        return "Wallets per second\n(WPS)";
      case ChartType.BPS:
        return "Brainwallet per second\n(BPS)";
      default:
        return "";
    }
  }

  static double getValue(BoostType boostType) {
    switch (boostType) {
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM;
      case BoostType.WPS_PREMIUM_2:
        return WPS_PREMIUM_2;
      case BoostType.WPS_PREMIUM_3:
        return WPS_PREMIUM_3;
    }
  }

  static dynamic boostTypeConvert(BoostType? boostType, String? _boostType) {
    if (boostType != null) {
      switch (boostType) {
        case BoostType.WPS_PREMIUM:
          return "WPS_PREMIUM";
        case BoostType.BPS_PREMIUM:
          return "BPS_PREMIUM";
        case BoostType.WPS_PREMIUM_2:
          return "WPS_PREMIUM_2";
        case BoostType.WPS_PREMIUM_3:
          return "WPS_PREMIUM_3";
      }
    } else if (_boostType != null) {
      switch (_boostType) {
        case "WPS_PREMIUM":
          return BoostType.WPS_PREMIUM;
        case "BPS_PREMIUM":
          return BoostType.BPS_PREMIUM;
      }
    }

    return null;
  }
}
