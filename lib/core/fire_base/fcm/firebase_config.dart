import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE",
          authDomain: "factor-flutter.firebaseapp.com",
          projectId: "factor-flutter",
          storageBucket: "factor-flutter.appspot.com",
          messagingSenderId: "1050573148656",
          appId: "1:1050573148656:web:0066d9606db59d63a6cd35",
          measurementId: "G-XHJ26XT7CD");
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:1050573148656:android:d2406e230599154ca6cd35',
        apiKey: 'AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE',
        projectId: 'factor-flutter',
        messagingSenderId: '1050573148656',
        authDomain: 'factor-flutter.firebaseapp.com',
        androidClientId:
            '1050573148656-n1s2sg8ip92skkio384d0bs4kue1pc1m.apps.googleusercontent.com',
      );
    }
  }
}
