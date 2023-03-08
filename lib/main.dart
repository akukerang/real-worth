import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_worth/components/test.dart';
import 'firebase_options.dart';
import "login_forms/login_page1.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test(),
    );
  }
}
