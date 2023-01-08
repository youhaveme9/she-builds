import 'package:flutter/material.dart';
import 'package:prega/widgets/heading.dart';

class Tips extends StatelessWidget {
  Tips({Key? key}) : super(key: key);

  final tipsList = [
    "Take folic acid and vitamin D supplements",
    "Consider having vaccinations that are offered",
    "Avoid diving or playing contact sports",
    "Don't eat unpasteurized milk products",
    "Don't sit in a hot tub or sauna",
    "Don't drink a lot of caffeine.",
    "Don't clean the cat's litter box",
    "Don't smoke",
    "Don't eat raw meat",
    "Monitor your baby’s movements",
    "Eat well and Stray active"
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          Heading(title: "Tips"),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: tipsList
                .map<Widget>((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(224, 175, 224, 226),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Text(e),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      )),
    );
  }
}
