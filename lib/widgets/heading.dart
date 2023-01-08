import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final title;
  const Heading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Image.asset(
            'assets/icons/icon.png',
            height: 45,
            width: 45,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 47, 46, 65),
            ),
          ),
        ],
      ),
    );
  }
}
