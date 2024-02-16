import 'dart:ffi';

import 'package:chat/firebase/userController.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/screen/chat_screen.dart';
import 'package:chat/shard_prf/SharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserController userController = UserController();
 String chat='';
  Future<void> createMessages({required MessageModel messageModel}) async {


    return await fireStore
        .collection('users')
        .doc(messageModel.sanderId)
        .collection('chats')
        .doc(messageModel.receiverId)
        .collection('messages')
        .doc(messageModel.dateTime)
        .set(messageModel.toMap())
        .then((value) {


      fireStore
          .collection('users')
          .doc(messageModel.receiverId)
          .collection('chats')
          .doc(messageModel.sanderId)
          .collection('messages')
          .doc(messageModel.dateTime)
          .set(messageModel.toMap())
          .then((value) {

      }).then((value) {



      });


    }).onError((error, stackTrace) {
      print(error);
    });


  }
  Stream<QuerySnapshot<MessageModel>> read({required chatId,required String currentUser}) async* {




    yield* fireStore
        .collection('users')
        .doc(currentUser)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .withConverter<MessageModel>(
            fromFirestore: (snapshot, options) =>
                MessageModel.fromMap(snapshot.data()!),
            toFirestore: (MessageModel value, options) => value.toMap())
        .orderBy('dateTime', descending: true)
        .snapshots();

}
}
