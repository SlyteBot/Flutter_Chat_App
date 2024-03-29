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
    apiKey: 'AIzaSyArKgayoerw4cd5Q1mlSl5Bc9Z-hMEq0oY',
    appId: '1:685057833346:web:724ffeea41b816f999779b',
    messagingSenderId: '685057833346',
    projectId: 'e2ee-flutterchat-app',
    authDomain: 'e2ee-flutterchat-app.firebaseapp.com',
    storageBucket: 'e2ee-flutterchat-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3kTB9pOXYcb8yefe2GxV0712ii_JI83M',
    appId: '1:685057833346:android:0f45910b745baa6899779b',
    messagingSenderId: '685057833346',
    projectId: 'e2ee-flutterchat-app',
    storageBucket: 'e2ee-flutterchat-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWCU3UdQzGNdLx5WsyH2E45VLXHaZaZeM',
    appId: '1:685057833346:ios:3f061965ee3f9a6299779b',
    messagingSenderId: '685057833346',
    projectId: 'e2ee-flutterchat-app',
    storageBucket: 'e2ee-flutterchat-app.appspot.com',
    iosClientId: '685057833346-lsrbggojm8hteg12qnc9h26v14tgki8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProjectChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBWCU3UdQzGNdLx5WsyH2E45VLXHaZaZeM',
    appId: '1:685057833346:ios:3f061965ee3f9a6299779b',
    messagingSenderId: '685057833346',
    projectId: 'e2ee-flutterchat-app',
    storageBucket: 'e2ee-flutterchat-app.appspot.com',
    iosClientId: '685057833346-lsrbggojm8hteg12qnc9h26v14tgki8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProjectChatApp',
  );
}
