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
    apiKey: 'AIzaSyBS4mEquTGPMBS-sMKvylxyVethm6RyVVQ',
    appId: '1:643718106978:web:ac28d5dfc772dc878c263b',
    messagingSenderId: '643718106978',
    projectId: 'centralized-emergency-services',
    authDomain: 'centralized-emergency-services.firebaseapp.com',
    storageBucket: 'centralized-emergency-services.appspot.com',
    measurementId: 'G-NYVJS6T5BJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIab4LTwheK3Q-xQy8qto_1XD1AlJypu8',
    appId: '1:643718106978:android:b3e3f1c69fc695128c263b',
    messagingSenderId: '643718106978',
    projectId: 'centralized-emergency-services',
    storageBucket: 'centralized-emergency-services.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoTSzMBcqTQS0vIvYPlP1WtJmx4-LWVTY',
    appId: '1:643718106978:ios:bfc086fc90f4a5c18c263b',
    messagingSenderId: '643718106978',
    projectId: 'centralized-emergency-services',
    storageBucket: 'centralized-emergency-services.appspot.com',
    iosClientId: '643718106978-5ae2ijh32p189bs5oe4q46brbevpriob.apps.googleusercontent.com',
    iosBundleId: 'com.example.ambulanceDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoTSzMBcqTQS0vIvYPlP1WtJmx4-LWVTY',
    appId: '1:643718106978:ios:bfc086fc90f4a5c18c263b',
    messagingSenderId: '643718106978',
    projectId: 'centralized-emergency-services',
    storageBucket: 'centralized-emergency-services.appspot.com',
    iosClientId: '643718106978-5ae2ijh32p189bs5oe4q46brbevpriob.apps.googleusercontent.com',
    iosBundleId: 'com.example.ambulanceDashboard',
  );
}