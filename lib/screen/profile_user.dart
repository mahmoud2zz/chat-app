import 'package:chat/firebase/message_controller.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/user_screen.dart';
import 'package:chat/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/userController.dart';

class ProfileUser extends StatelessWidget {
  late String? email;
  late String? imageUser;

  ProfileUser({Key? key, this.email, this.imageUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<UserModel>>(
      stream: UserController().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text( snapshot.data!.docs[index].data().email),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                    snapshot.data!.docs[index].data().image,
                  ),),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 1,);
              },
              itemCount: snapshot.data!.size);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
