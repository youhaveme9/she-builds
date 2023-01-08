import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prega/provider/google_signin.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Material(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset("assets/images/login.png"),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 46, 65),
                fixedSize: const Size(240, 46)),
            label: const Text(
              "Login",
              style: TextStyle(fontSize: 18),
            ),
            icon: const FaIcon(FontAwesomeIcons.google),
          ),
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            "assets/icons/icon.png",
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "You care for the baby",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "We care for everything",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ));
  }
}
