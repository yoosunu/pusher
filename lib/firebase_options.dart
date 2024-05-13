// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCTAGMr0hi9NBUI6c9G-3vrlWhQXLWMAt4',
    appId: '1:214040558475:web:675d460893b19a0757cd8e',
    messagingSenderId: '214040558475',
    projectId: 'flutterapp-648f4',
    authDomain: 'flutterapp-648f4.firebaseapp.com',
    databaseURL: 'https://flutterapp-648f4-default-rtdb.firebaseio.com',
    storageBucket: 'flutterapp-648f4.appspot.com',
    measurementId: 'G-Q2ZDGCJ3P2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX9h0E8jPyx6IHjh1NQoAgYKhMaYTmu3s',
    appId: '1:214040558475:android:d5433052a3acda2b57cd8e',
    messagingSenderId: '214040558475',
    projectId: 'flutterapp-648f4',
    databaseURL: 'https://flutterapp-648f4-default-rtdb.firebaseio.com',
    storageBucket: 'flutterapp-648f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdoaN5TzOFh_HInRBjHa50VmMS2NBjZAQ',
    appId: '1:214040558475:ios:75cf7b4bdc2aab9957cd8e',
    messagingSenderId: '214040558475',
    projectId: 'flutterapp-648f4',
    databaseURL: 'https://flutterapp-648f4-default-rtdb.firebaseio.com',
    storageBucket: 'flutterapp-648f4.appspot.com',
    iosBundleId: 'com.example.pusher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdoaN5TzOFh_HInRBjHa50VmMS2NBjZAQ',
    appId: '1:214040558475:ios:75cf7b4bdc2aab9957cd8e',
    messagingSenderId: '214040558475',
    projectId: 'flutterapp-648f4',
    databaseURL: 'https://flutterapp-648f4-default-rtdb.firebaseio.com',
    storageBucket: 'flutterapp-648f4.appspot.com',
    iosBundleId: 'com.example.pusher',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTAGMr0hi9NBUI6c9G-3vrlWhQXLWMAt4',
    appId: '1:214040558475:web:5e536d18da97281657cd8e',
    messagingSenderId: '214040558475',
    projectId: 'flutterapp-648f4',
    authDomain: 'flutterapp-648f4.firebaseapp.com',
    databaseURL: 'https://flutterapp-648f4-default-rtdb.firebaseio.com',
    storageBucket: 'flutterapp-648f4.appspot.com',
    measurementId: 'G-9N6YP4Q9V5',
  );

}