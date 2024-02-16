import 'package:chat/firebase/auth_controller.dart';
import 'package:chat/firebase/userController.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/chat_screen.dart';
import 'package:chat/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../shard_prf/SharedPref.dart';
import '../utils/snak_bar.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  static String id = '/user_screen';
 late String email;
  late String imageUser;

  get getEmail=>email;
  get getImageUser=>imageUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot<UserModel>>(
          stream: UserController().getUsers(),
          builder: (context, snapshot) {


            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()async {


                        Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatScreen(email: snapshot.data!.docs[index].data().email,image:snapshot.data!.docs[index].data().image,receiverId: snapshot.data!.docs[index].data().uid,)));
                     await   SharedPref.savaData(key: 'uidReceive',value:snapshot.data!.docs[index].data().uid);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(snapshot
                                .data!.docs[index]
                                .data()
                                .image
                                .toString())),
                        title: Text(
                          snapshot.data!.docs[index].data().email,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.shade400,
                    );
                  },
                  itemCount: snapshot.data!.size);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
