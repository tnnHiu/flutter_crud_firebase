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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDzArmVWrQD-lyTCfJ8nW8jVSsG-6RqoiM',
    appId: '1:516959738561:web:4241284d1c2dd3fa649240',
    messagingSenderId: '516959738561',
    projectId: 'grocery-management-4dffa',
    authDomain: 'grocery-management-4dffa.firebaseapp.com',
    storageBucket: 'grocery-management-4dffa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvFcG3hM0nfAUJZJq9lr-ytau2MMmm2aM',
    appId: '1:516959738561:android:214c81c31328db24649240',
    messagingSenderId: '516959738561',
    projectId: 'grocery-management-4dffa',
    storageBucket: 'grocery-management-4dffa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVFk75-kq1kd9qhbkfmsohTeRJPnHHDfM',
    appId: '1:516959738561:ios:93e24742782ab450649240',
    messagingSenderId: '516959738561',
    projectId: 'grocery-management-4dffa',
    storageBucket: 'grocery-management-4dffa.appspot.com',
    iosBundleId: 'com.example.groceryManagement',
  );
}
