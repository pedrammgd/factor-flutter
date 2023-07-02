// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE',
    appId: '1:1050573148656:web:0066d9606db59d63a6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    authDomain: 'factor-flutter.firebaseapp.com',
    storageBucket: 'factor-flutter.appspot.com',
    measurementId: 'G-XHJ26XT7CD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCypdKFLL3qxycgyAucvCvDts63AYCrCGQ',
    appId: '1:1050573148656:android:d2406e230599154ca6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    storageBucket: 'factor-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDi_hwMKXDXJqLcksMzYRSOvEsEIVSKgbM',
    appId: '1:1050573148656:ios:469f1c1dbe6b9648a6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    storageBucket: 'factor-flutter.appspot.com',
    androidClientId: '1050573148656-n1s2sg8ip92skkio384d0bs4kue1pc1m.apps.googleusercontent.com',
    iosClientId: '1050573148656-jjdus5o0upbie62eslguqvse72dv7cue.apps.googleusercontent.com',
    iosBundleId: 'com.example.factorFlutterMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDi_hwMKXDXJqLcksMzYRSOvEsEIVSKgbM',
    appId: '1:1050573148656:ios:469f1c1dbe6b9648a6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    storageBucket: 'factor-flutter.appspot.com',
    androidClientId: '1050573148656-n1s2sg8ip92skkio384d0bs4kue1pc1m.apps.googleusercontent.com',
    iosClientId: '1050573148656-jjdus5o0upbie62eslguqvse72dv7cue.apps.googleusercontent.com',
    iosBundleId: 'com.example.factorFlutterMobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE',
    appId: '1:1050573148656:web:41c838d7503fbb4da6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    authDomain: 'factor-flutter.firebaseapp.com',
    storageBucket: 'factor-flutter.appspot.com',
    measurementId: 'G-MQ0SZ0407P',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE',
    appId: '1:1050573148656:web:fe2f1a60cccc9fe5a6cd35',
    messagingSenderId: '1050573148656',
    projectId: 'factor-flutter',
    authDomain: 'factor-flutter.firebaseapp.com',
    storageBucket: 'factor-flutter.appspot.com',
    measurementId: 'G-0D73SDYKZV',
  );
}
