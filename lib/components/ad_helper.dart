import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/9214589741';
    } else {
      // ignore: unnecessary_new
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstatialAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      // ignore: unnecessary_new
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
