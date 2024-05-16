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
    apiKey: 'AIzaSyDf5YmgiKSmDRU6m2DdlY13K2wMFGdvZzw',
    appId: '1:374587675989:web:c84f2ea17447af5050cbdc',
    messagingSenderId: '374587675989',
    projectId: 'mealmatch-632dd',
    authDomain: 'mealmatch-632dd.firebaseapp.com',
    storageBucket: 'mealmatch-632dd.appspot.com',
    measurementId: 'G-0P9ET33QQP',
    databaseURL: "https://mealmatch-632dd-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeXxcAvrpKW0n-DuF9ZLqetiIYerVpdKw',
    appId: '1:374587675989:android:642745c65a185ccc50cbdc',
    messagingSenderId: '374587675989',
    projectId: 'mealmatch-632dd',
    storageBucket: 'mealmatch-632dd.appspot.com',
    databaseURL: "https://mealmatch-632dd-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC31QSIzPBAhRj_W5IbG3UY0yhBnVYlfLQ',
    appId: '1:374587675989:ios:670f42de1b33f63f50cbdc',
    messagingSenderId: '374587675989',
    projectId: 'mealmatch-632dd',
    storageBucket: 'mealmatch-632dd.appspot.com',
    iosClientId:
        '374587675989-3g5s9jhqee22h37q27vp22c2bf21gu75.apps.googleusercontent.com',
    iosBundleId: 'com.example.mealmatch',
    databaseURL: "https://mealmatch-632dd-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC31QSIzPBAhRj_W5IbG3UY0yhBnVYlfLQ',
    appId: '1:374587675989:ios:670f42de1b33f63f50cbdc',
    messagingSenderId: '374587675989',
    projectId: 'mealmatch-632dd',
    storageBucket: 'mealmatch-632dd.appspot.com',
    iosClientId:
        '374587675989-3g5s9jhqee22h37q27vp22c2bf21gu75.apps.googleusercontent.com',
    iosBundleId: 'com.example.mealmatch',
    databaseURL: "https://mealmatch-632dd-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDf5YmgiKSmDRU6m2DdlY13K2wMFGdvZzw',
    appId: '1:374587675989:web:2014d29332e458f450cbdc',
    messagingSenderId: '374587675989',
    projectId: 'mealmatch-632dd',
    authDomain: 'mealmatch-632dd.firebaseapp.com',
    storageBucket: 'mealmatch-632dd.appspot.com',
    measurementId: 'G-8W6SS9YF0D',
    databaseURL: "https://mealmatch-632dd-default-rtdb.asia-southeast1.firebasedatabase.app",
  );
}
