import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Configuração do Firebase.
///
/// Substitua os valores abaixo pelos dados do seu projeto Firebase.
/// No Firebase Console: Configurações do projeto > Seus apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCpCutmWzJxSVpkEYSdqXnOPwRp_MJ1tbw",
    authDomain: "aulafirebase-a34e4.firebaseapp.com",
    projectId: "aulafirebase-a34e4",
    storageBucket: "aulafirebase-a34e4.firebasestorage.app",
    messagingSenderId: "867326745584",
    appId: "1:867326745584:web:46be238d712b04f8d51b35",
    measurementId: "G-SBS3DDFN9H",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCpCutmWzJxSVpkEYSdqXnOPwRp_MJ1tbw",
    authDomain: "aulafirebase-a34e4.firebaseapp.com",
    projectId: "aulafirebase-a34e4",
    storageBucket: "aulafirebase-a34e4.firebasestorage.app",
    messagingSenderId: "867326745584",
    appId: "1:867326745584:web:46be238d712b04f8d51b35",
    measurementId: "G-SBS3DDFN9H",
  );
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyCpCutmWzJxSVpkEYSdqXnOPwRp_MJ1tbw",
    authDomain: "aulafirebase-a34e4.firebaseapp.com",
    projectId: "aulafirebase-a34e4",
    storageBucket: "aulafirebase-a34e4.firebasestorage.app",
    messagingSenderId: "867326745584",
    appId: "1:867326745584:web:46be238d712b04f8d51b35",
    measurementId: "G-SBS3DDFN9H",
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: "AIzaSyCpCutmWzJxSVpkEYSdqXnOPwRp_MJ1tbw",
    authDomain: "aulafirebase-a34e4.firebaseapp.com",
    projectId: "aulafirebase-a34e4",
    storageBucket: "aulafirebase-a34e4.firebasestorage.app",
    messagingSenderId: "867326745584",
    appId: "1:867326745584:web:46be238d712b04f8d51b35",
    measurementId: "G-SBS3DDFN9H",
  );
}
