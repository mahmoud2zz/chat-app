import 'package:flutter/material.dart';

import '../themes.dart';

class CustomButton extends StatelessWidget {
  Widget title;
  VoidCallback? onPressed;

   CustomButton({
    Key? key,
     required this.title,
     required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
            primary: Colors.blue, minimumSize: Size(double.infinity, 55,)),
        onPressed: onPressed,
        child:title,);
  }
}