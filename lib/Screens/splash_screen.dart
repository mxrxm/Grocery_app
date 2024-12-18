import 'package:flutter/material.dart';
import 'package:grocery_app/Screens//start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const start_screen()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(71, 152, 100, 1),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 280)),
          Center(
            child: Image.asset(
              "images/splash_screen.jpeg",
              height: 200,
            ),
          ),
          const Text("Welcome",
              style: TextStyle(
                  fontFamily: "gilroy",
                  fontSize: 48,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w600)),
          const Text("online shopping",
              style: TextStyle(
                  fontFamily: "gilroy",
                  letterSpacing: 14,
                  fontSize: 18,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.normal)),
          const Spacer(),
        ],
      ),
    );
  }
}
