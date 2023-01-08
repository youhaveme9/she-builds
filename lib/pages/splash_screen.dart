import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/icons/icon.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 33,
            ),
            const Text(
              "Prega.io",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 81, 166, 227),
                  fontWeight: FontWeight.bold),
            ),
          ],
        )));
  }
}
