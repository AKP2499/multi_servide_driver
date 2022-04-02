import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Page Not Found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset('lib/lottie_json/unknownRoute.json')
        ],
      ),
    );
  }
}