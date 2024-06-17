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
    apiKey: 'AIzaSyD7sw-YTzvHMZNxlpTif0ok7i2WoQ97kl8',
    appId: '1:114344742984:web:57edc20a55c7edbdc8c87d',
    messagingSenderId: '114344742984',
    projectId: 'tutoring-a550b',
    authDomain: 'tutoring-a550b.firebaseapp.com',
    storageBucket: 'tutoring-a550b.appspot.com',
    measurementId: 'G-SXDFDV4HGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKQlyiqixHjYGsDN32BvsXRFIUu5y7J-Y',
    appId: '1:114344742984:android:be23a537d39732b1c8c87d',
    messagingSenderId: '114344742984',
    projectId: 'tutoring-a550b',
    storageBucket: 'tutoring-a550b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiylSvmKkb1VJE4GpQKJ8ouLXPA35j1Qo',
    appId: '1:114344742984:ios:b2e866f7326a8f5ac8c87d',
    messagingSenderId: '114344742984',
    projectId: 'tutoring-a550b',
    storageBucket: 'tutoring-a550b.appspot.com',
    iosBundleId: 'com.example.tutorinsa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiylSvmKkb1VJE4GpQKJ8ouLXPA35j1Qo',
    appId: '1:114344742984:ios:b2e866f7326a8f5ac8c87d',
    messagingSenderId: '114344742984',
    projectId: 'tutoring-a550b',
    storageBucket: 'tutoring-a550b.appspot.com',
    iosBundleId: 'com.example.tutorinsa',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7sw-YTzvHMZNxlpTif0ok7i2WoQ97kl8',
    appId: '1:114344742984:web:399c7639c1ae4bd1c8c87d',
    messagingSenderId: '114344742984',
    projectId: 'tutoring-a550b',
    authDomain: 'tutoring-a550b.firebaseapp.com',
    storageBucket: 'tutoring-a550b.appspot.com',
    measurementId: 'G-Z9RN3917SJ',
  );
}
