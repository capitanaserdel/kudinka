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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD3bIQ8xDvWFP5ljG-dyZ56x4Ltx-io8tk',
    appId: '1:489282453322:web:7fac9caf886b1e7a33cbb3',
    messagingSenderId: '489282453322',
    projectId: 'kudikan-67e90',
    authDomain: 'kudikan-67e90.firebaseapp.com',
    databaseURL: 'https://kudikan-67e90-default-rtdb.firebaseio.com',
    storageBucket: 'kudikan-67e90.appspot.com',
    measurementId: 'G-DY7XW2XQCL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTJN1cJ7UIxcgM4TwV4_-wOyL-q6sH5ys',
    appId: '1:489282453322:android:2ed47dca58115bd033cbb3',
    messagingSenderId: '489282453322',
    projectId: 'kudikan-67e90',
    databaseURL: 'https://kudikan-67e90-default-rtdb.firebaseio.com',
    storageBucket: 'kudikan-67e90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBhdKBF6022MpnA5_ceF0CfJIsevyU7Zw',
    appId: '1:489282453322:ios:ca50fedd3b94b62f33cbb3',
    messagingSenderId: '489282453322',
    projectId: 'kudikan-67e90',
    databaseURL: 'https://kudikan-67e90-default-rtdb.firebaseio.com',
    storageBucket: 'kudikan-67e90.appspot.com',
    iosClientId: '489282453322-turuj0el8tsnspo6rfjkoe90bbeak2ep.apps.googleusercontent.com',
    iosBundleId: 'com.example.kudinkaa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBhdKBF6022MpnA5_ceF0CfJIsevyU7Zw',
    appId: '1:489282453322:ios:ca50fedd3b94b62f33cbb3',
    messagingSenderId: '489282453322',
    projectId: 'kudikan-67e90',
    databaseURL: 'https://kudikan-67e90-default-rtdb.firebaseio.com',
    storageBucket: 'kudikan-67e90.appspot.com',
    iosClientId: '489282453322-turuj0el8tsnspo6rfjkoe90bbeak2ep.apps.googleusercontent.com',
    iosBundleId: 'com.example.kudinkaa',
  );
}