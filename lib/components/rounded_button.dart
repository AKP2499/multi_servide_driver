


import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title,required this.colors,required this.onPressed,required this.authController});
  final Color colors;
  final String title;
  final Function onPressed;

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20,10,20,10),
      padding: const EdgeInsets.fromLTRB(10,2,10,2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: (authController.isChecked.value)
              ? colors
              : Colors.grey,
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPressed(),
        child:  Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
