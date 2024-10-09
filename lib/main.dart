import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_management/firebase_options.dart';
import 'package:grocery_management/services/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Grocery",
      home: const AuthGate(),
    );
  }
}
