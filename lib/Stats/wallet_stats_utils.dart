// ignore_for_file: constant_identifier_names

import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';

const double WPS_ADS = 1;
const double BPS_ADS = 0.5;
const double WPS_PREMIUM = 5;
const double BPS_PREMIUM = 2.5;

const int WPS_ADS_SECONDS = 300;
const int BPS_ADS_SECONDS = 150;

const String WPS_ADS_BUTTON_DESCRIPTION = "Increase WPS by 1 for 5 minutes";
const String BPS_ADS_BUTTON_DESCRIPTION = "Increase BPS by 0.5 for 5 minutes";
const String WPS_PREMIUM_BUTTON_DESCRIPTION = "Increase WPS by 5 for ever";
const String BPS_PREMIUM_BUTTON_DESCRIPTION = "Increase BPS by 2.5 for ever";

const String WPS_ADS_BUTTON_TITLE = "WATCH AN AD";
const String BPS_ADS_BUTTON_TITLE = "WATCH AN AD";
const String WPS_PREMIUM_BUTTON_TITLE = "0.99\$";
const String BPS_PREMIUM_BUTTON_TITLE = "0.99\$";

const String WPS_CHART_TITLE = "Wallets per second\n(WPS)";
const String BPS_CHART_TITLE = "Wallets per second\n(WPS)";

class WalletStatsUtils
{
  static String getButtonTitle(BoostType boostType){
    switch(boostType){
      case BoostType.WPS_ADS:
        return WPS_ADS_BUTTON_TITLE;
      case BoostType.BPS_ADS:
        return BPS_ADS_BUTTON_TITLE;
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM_BUTTON_TITLE;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM_BUTTON_TITLE;
    }
  }

  static String getButtonDescription(BoostType boostType){
    switch(boostType){
      case BoostType.WPS_ADS:
        return WPS_ADS_BUTTON_DESCRIPTION;
      case BoostType.BPS_ADS:
        return BPS_ADS_BUTTON_DESCRIPTION;
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM_BUTTON_DESCRIPTION;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM_BUTTON_DESCRIPTION;
    }
  }

  static String getChartTitle(ChartType chartType){
    switch(chartType){
      case ChartType.WPS :
        return "Wallets per second\n(WPS)";
      case ChartType.BPS :
        return "Brainwallet per second\n(BPS)";
      default :
        return "";
    }
  }

  static double getValue(BoostType boostType){
    switch(boostType){
      case BoostType.WPS_ADS:
        return WPS_ADS;
      case BoostType.BPS_ADS:
        return BPS_ADS;
      case BoostType.WPS_PREMIUM:
        return WPS_PREMIUM;
      case BoostType.BPS_PREMIUM:
        return BPS_PREMIUM;
    }
  }

  static int getSeconds(BoostType boostType){
    switch(boostType){
      case BoostType.WPS_ADS:
        return WPS_ADS_SECONDS;
      case BoostType.BPS_ADS:
        return BPS_ADS_SECONDS;
      case BoostType.WPS_PREMIUM:
        return 0;
      case BoostType.BPS_PREMIUM:
        return 0;
    }
  }
}