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
    apiKey: 'AIzaSyCgD7xWrnFVhU3VSGzZPMbjVtvNb7Rr6IA',
    appId: '1:484684647105:web:3e301172ab41f0c894a240',
    messagingSenderId: '484684647105',
    projectId: 'stroryflakes',
    authDomain: 'stroryflakes.firebaseapp.com',
    databaseURL: 'https://stroryflakes-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'stroryflakes.appspot.com',
    measurementId: 'G-QKL9V0R31X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWbQOrs-Rmw6A_gUGt_5vfazfLS4VV3vU',
    appId: '1:484684647105:android:90a5a4b85630a63494a240',
    messagingSenderId: '484684647105',
    projectId: 'stroryflakes',
    databaseURL: 'https://stroryflakes-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'stroryflakes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAP02ihdaMS0nYDwkHXFoagMF-nBX3b0q4',
    appId: '1:484684647105:ios:1ac3d953b56eaa1894a240',
    messagingSenderId: '484684647105',
    projectId: 'stroryflakes',
    databaseURL: 'https://stroryflakes-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'stroryflakes.appspot.com',
    iosBundleId: 'com.metacontent.storyFlakes',
  );
}
