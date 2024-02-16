import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/snak_bar.dart';

class AuthController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> singOut() async => auth.signOut();

  Future singUp(context, {required String email, required password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SankBers.showSnackBarSuccess(context, message: 'register success');
      return userCredential;
    } catch (e) {
      SankBers.showSnackBarError(context, errorMessage: e.toString());
    }
  }



  Future<UserCredential?> signIn(context, {required emiel, required password}) async {
    UserCredential? userCredential;
    try {
     userCredential = await auth.signInWithEmailAndPassword(
          email: emiel, password: password);

      SankBers.showSnackBarSuccess(context, message: 'login success');
    } catch (e) {
      SankBers.showSnackBarError(context, errorMessage: e.toString());
    }
    return userCredential;
  }
  get currentUser=>auth.currentUser?.uid;

}


