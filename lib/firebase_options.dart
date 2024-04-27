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
    apiKey: 'AIzaSyDUcLRRxyo9-Aflejvb1lOHx7KLjqNR3cY',
    appId: '1:768514970805:web:ae5bf352d5417b6f1cdafc',
    messagingSenderId: '768514970805',
    projectId: 'instant-mechanic-app-2eae8',
    authDomain: 'instant-mechanic-app-2eae8.firebaseapp.com',
    storageBucket: 'instant-mechanic-app-2eae8.appspot.com',
    measurementId: 'G-ZPD7BBJS66',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAywjDaeAh1aKKC3x05LUKtyMiIYvP6pCU',
    appId: '1:768514970805:android:3f8913d1393aafcb1cdafc',
    messagingSenderId: '768514970805',
    projectId: 'instant-mechanic-app-2eae8',
    storageBucket: 'instant-mechanic-app-2eae8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa7ZwKFnlNb6-gqUD-7ZTWPUIAgfGeV8c',
    appId: '1:768514970805:ios:61f0efbacc9162391cdafc',
    messagingSenderId: '768514970805',
    projectId: 'instant-mechanic-app-2eae8',
    storageBucket: 'instant-mechanic-app-2eae8.appspot.com',
    iosBundleId: 'com.example.carMechanics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAa7ZwKFnlNb6-gqUD-7ZTWPUIAgfGeV8c',
    appId: '1:768514970805:ios:61f0efbacc9162391cdafc',
    messagingSenderId: '768514970805',
    projectId: 'instant-mechanic-app-2eae8',
    storageBucket: 'instant-mechanic-app-2eae8.appspot.com',
    iosBundleId: 'com.example.carMechanics',
  );
}
