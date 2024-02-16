
import 'package:flutter/material.dart';

class SankBers{

 static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarSuccess(
      context,
      {required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green, content: Text(message)),
    );
  }

 static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarError(
      context,
      {required String errorMessage}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red.shade700, content: Text(errorMessage)),
    );
  }




}