import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdMob{

  static RewardedAd? rewardedAd;

  // REWARDED AD
  static void loadRewardedAd(){
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // TEST ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      )
    );
  }

  static void showRewardedAd(){
    rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      print("ad watched");
      loadRewardedAd();
    });
  }
}