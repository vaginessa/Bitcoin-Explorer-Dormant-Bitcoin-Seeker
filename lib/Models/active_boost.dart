
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats_utils.dart';

class ActiveBoost{

  BoostType boostType;
  String endTime;

  ActiveBoost({
    required this.endTime,
    required this.boostType,
  });

  Map<String,String> toMap(){
    return {
      "boost type" : WalletStatsUtils.boostTypeConvert(boostType,null),
      "end time" : endTime
    };
  }
}