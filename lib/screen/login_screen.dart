import 'package:chat/screen/chat_screen.dart';
import 'package:chat/screen/home_screen.dart';
import 'package:chat/screen/register_screen.dart';
import 'package:chat/screen/user_screen.dart';
import 'package:chat/shard_prf/SharedPref.dart';
import 'package:chat/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase/auth_controller.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  GlobalKey<FormState> formKey = GlobalKey();

  String password = '';

  AuthController authController = AuthController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 205,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextFiled(
                  obscureText: false,
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFiled(
                  obscureText: true,
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    if (formKey.currentState!.validate()) {
                      try {
                        await authController.signIn(context,
                            emiel: email, password: password);
                        await SharedPref.savaData(
                            key: 'uid', value: AuthController().currentUser);
                        Navigator.pushNamed(context, HomeScreen.id);
                      } catch (e) {
                        print(e.toString());
                        isLoading = false;
                      }
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\' have account?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen())),
                        child: Text(
                          ' Register',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
