
import 'package:dormant_bitcoin_seeker_flutter/Stats/types.dart';

class ActiveBoost{
  
  double value;
  BoostType boostType;
  String startTime;
  String duration;

  ActiveBoost({
    required this.startTime,
    required this.boostType,
    required this.value,
    required this.duration
  });
}