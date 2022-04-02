import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          // Image.asset("lib/Images/Wedun Logo Without Backgorund-01.png",height: 100,width: 100,),
          Image.asset("lib/Images/maintenance.png",)
          // Lottie.asset('lib/lottie_json/maintenance.json'),
        ],
      ),
    );
  }
}