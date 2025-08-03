import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobManager {
  final AdManagerBannerAd _adBanner;
  AdMobManager()
      : _adBanner = AdManagerBannerAd(
          adUnitId: 'ca-app-pub-8735314159015654/5158508662',
          sizes: [AdSize.banner],
          request: AdManagerAdRequest(),
          listener: AdManagerBannerAdListener(
            onAdLoaded: (Ad ad) => debugPrint('Ad loaded: ${ad.adUnitId}'),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              debugPrint('Ad failed to load: ${error.message}');
              ad.dispose();
            },
          ),
        ); // 広告のロード

  Future<void> loadAd() async {
    await _adBanner.load();
  } // 広告をウィジェットとして返す

  Widget getAdWidget() {
    return Container(
      alignment: Alignment.center,
      width: _adBanner.sizes[0].width.toDouble(),
      height: _adBanner.sizes[0].height.toDouble(),
      child: AdWidget(ad: _adBanner),
    );
  } // 広告の破棄

  void dispose() {
    _adBanner.dispose();
  }
}

//class AdMobManager {
//  final String adUnitId;
//  BannerAd? _bannerAd;
//
//  AdMobManager(this.adUnitId);
//
//  Future<void> loadAd() async {
//    _bannerAd = BannerAd(
//      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
//      size: AdSize.banner,
//      request: AdRequest(),
//      listener: BannerAdListener(
//        onAdLoaded: (_) {
//          print('Ad loaded successfully.');
//        },
//        onAdFailedToLoad: (ad, error) {
//          print('Failed to load an ad: ${error.message}');
//          ad.dispose();
//        },
//      ),
//    );
//    await _bannerAd!.load();
//  }
//
//  void dispose() {
//    _bannerAd?.dispose();
//  }
//
//  BannerAd? get bannerAd => _bannerAd;
//}
//
