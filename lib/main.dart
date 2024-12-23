import 'package:flutter/material.dart';
import 'package:grocery_app/Screens//splash_screen.dart';
import 'package:code_uml/code_uml.dart';
// Entry point of the Flutter application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // The first screen displayed in the app
    return const MaterialApp(home: SplashScreen());
  }
}
