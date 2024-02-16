import 'package:chat/firebase/auth_controller.dart';
import 'package:chat/firebase/userController.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shard_prf/SharedPref.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_filed.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = AuthController();
  UserCredential? userCredential;
  String email = '';
  GlobalKey<FormState> formKey = GlobalKey();
  String password = '';
  bool isLoading = false;
  UserModel get user {
    UserModel userModel = UserModel();
    userModel.email = userCredential!.user!.email!;
    userModel.uid =userCredential!.user!.uid;

    return userModel;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
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
                    'Register',
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
                          'Register',
                          style: TextStyle(color: Colors.blue),
                        ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (formKey.currentState!.validate()) {
                   {
                     try{
                       userCredential= await authController.singUp(context,
                           email: email, password: password);
                       UserController().createUser(user);
                     }catch(e){
                       setState(() {
                         isLoading=false;
                       });

                     }
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
                      'do you have account?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text(' Login', style: TextStyle(color: Colors.blue)),
                    ),
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
