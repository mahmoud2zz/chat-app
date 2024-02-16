import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  late String hintText;
  late bool obscureText;
  ValueChanged?onChanged;
  CustomTextFiled({
    Key? key,
    required this.obscureText,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ,
     onChanged:onChanged ,
      validator: (data){
       if(data!.isEmpty) {
         print('sssssssssssss');
         return   'filed is required' ;
       }
      },
      decoration: InputDecoration(
          hintText:hintText,
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            ),
          border: OutlineInputBorder(
          )),

    );
  }
}
