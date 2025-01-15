import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('Before Firebase initialization: ${Firebase.apps}');

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBaoP38CU5l6mCNbhbvR9EfRvlJNIIprKc',
        appId: '1:462572484040:android:e527370e49ef920a7fbcfd',
        messagingSenderId: '462572484040',
        projectId: 'mis3-bfdfa',
      ),
    );
    debugPrint('Firebase initialized successfully.');
  }else{
    debugPrint('Firebase initialized successfully.');
  }

  try {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    debugPrint('Firebase Auth emulator configured.');
  } catch (e) {
    debugPrint('Firebase Auth emulator is already initialized: $e');
  }
}