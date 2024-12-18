import 'package:flutter/material.dart';
import 'package:grocery_app/Screens//sign_up.dart';

// Defining the start screen as a stateless widget
class start_screen extends StatelessWidget {
  const start_screen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Scaffold to create the basic structure of the screen
    return Scaffold(
        body: Container(
          // Adding a background image for the screen
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/start_screen.jpg"),
            fit: BoxFit.cover,
            opacity: 0.9),
      ),
      // Centering the content of the screen
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Adds vertical space at the top
            const Padding(padding: EdgeInsets.only(top: 320)),
            const Text("Welcome",
                style: TextStyle(
                    fontFamily: "gilroy",
                    fontSize: 48,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600)),
            const Text("to our store",
                style: TextStyle(
                    fontFamily: "gilroy",
                    fontSize: 48,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600)),
            const Text("Your Food Journey Starts Here",
                style: TextStyle(
                    fontFamily: "gilroy",
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600)),
            // Adds vertical space
            const SizedBox(height: 18),
            // "Sign Up" button
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => sign_up()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 53),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(71, 152, 100, 1),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "gilroy",
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  //minimumSize: const Size.fromHeight(50),
                ),
                child: const Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Center(
                        child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "gilroy",
                          fontSize: 24),
                    ))
                  ],
                )),
            // Adds flexible space at the bottom
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
