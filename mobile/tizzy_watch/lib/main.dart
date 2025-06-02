import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isGooglePlayServicesAvailable = await FirebaseMessaging.instance
      .setAutoInitEnabled(true)
      .then((_) => true)
      .catchError((_) => false);

  if (!isGooglePlayServicesAvailable) {
    print("Google Play Services is not available. Please install or update it.");
  } else {
    print("Google Play Services is available.");
  }

  runApp(ProviderScope(child: MainApp()));
}
