import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/app.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:t_ecommerce_admin_panel/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (_) => Get.put(
      AuthenticationRepository(),
    ),
  );
  // Main App Starts here...
  runApp(const App());
}
