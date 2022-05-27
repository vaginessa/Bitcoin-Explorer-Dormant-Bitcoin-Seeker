import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdMob{

  static RewardedAd? _rewardedAd;
  static int attempts = 0;
  static bool? adResponse;

  static void interstialLoad(bool show) async{
    await RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917", 
      request: const AdRequest(), 
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          print("AD LOADED.");
          attempts = 0;

          if(show){
            showInterstitial();
          }
        }, 
        onAdFailedToLoad: (LoadAdError error){
          print("AD FAILED TO LOAD.");
          print(error);
          attempts++;
          _rewardedAd = null;

          if(attempts <= 2){
            interstialLoad(false);
          }
        }
      )
    );
  }

  static void showInterstitial(){
    if(_rewardedAd == null){
      interstialLoad(true);
    }
    
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad){
        print("AD SHOWED");
      },
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("AD DISMISSED");
        adResponse = false;
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad,AdError error){
        print("AD FAILED");
        ad.dispose();
        adResponse = false;
      },
      onAdImpression: (RewardedAd ad){
        print("AD IMPRESSION");
      },
      onAdWillDismissFullScreenContent: (RewardedAd ad){
        adResponse = false;
      }
    );

    _rewardedAd?.show(onUserEarnedReward: (ad, reward) {
      adResponse = true;
    });

    _rewardedAd = null;
    interstialLoad(false);
  }
}