import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdMob{

  static InterstitialAd? _interstitialAd;
  static int num_of_attempt_load = 0;

  static void interstialLoad(bool show) async{
    await InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712", 
      request: AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          print("AD LOADED.");
          num_of_attempt_load = 0;

          if(show){
            showInterstitial();
          }
        }, 
        onAdFailedToLoad: (LoadAdError error){
          print("AD FAILED TO LOAD.");
          print(error);
          num_of_attempt_load++;
          _interstitialAd = null;

          if(num_of_attempt_load <= 2){
            interstialLoad(false);
          }
        }
      )
    );
  }

  static void showInterstitial(){
    if(_interstitialAd == null){
      interstialLoad(true);
    }
    
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad){
        print("AD SHOWED");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad){
        print("AD DISMISSED");
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){
        print("AD FAILED");
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad){
        print("AD IMPRESSION");
      }
    );

    _interstitialAd?.show();
    _interstitialAd = null;
    interstialLoad(false);
  }
}