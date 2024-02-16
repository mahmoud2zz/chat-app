import 'package:chat/model/message_model.dart';
import 'package:chat/shard_prf/SharedPref.dart';
import 'package:chat/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/message_controller.dart';

class ChatScreen extends StatefulWidget {
  late String receiverId;
  late String image;
  late String email;

  ChatScreen({Key? key, this.email = '', this.image = '', this.receiverId = ''})
      : super(key: key);

  static String id = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controllerBody = TextEditingController();

  ScrollController scrollController = ScrollController();
 String chat=SharedPref.getDate(key: 'uidReceive');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.cardDark,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              widget.image,
            ),
          ),
        ),
        title: Text(widget.email),
      ),
      body: StreamBuilder<QuerySnapshot<MessageModel>>(
        stream: MessageController().read(
            chatId:chat,
            currentUser: SharedPref.getDate(key: 'uid')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        reverse: true,
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [

                              if (snapshot.data!.docs[index].data().sanderId ==
                                 message.sanderId)
                                Align(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32),
                                          bottomRight: Radius.circular(32),
                                        )),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                          .data()
                                          .bodyMessage
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                              if (snapshot.data!.docs[index]
                                  .data().receiverId
                                  ==message.sanderId
                              )
                                Align(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32),
                                          bottomLeft: Radius.circular(32),
                                        )),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                          .data()
                                          .bodyMessage,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                  ),
                                  alignment: AlignmentDirectional.topEnd,
                                ),
                              SizedBox(
                                height: 5,
                              ),

                              SizedBox(
                                height: 0,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 0,
                          );
                        },
                        itemCount: snapshot.data!.docs.length),
                  ),
                  TextField(
                    controller: controllerBody,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          print(controllerBody.text);
                          await MessageController().createMessages(
                            messageModel: message,
                          );
                          controllerBody.clear();
                          scrollController.animateTo(0,
                              duration: const Duration(microseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        },
                        icon: Icon(
                          Icons.send,
                          color: AppThemes.cardDark,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Spacer(),
                TextField(
                  controller: controllerBody,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await MessageController().createMessages(
                          messageModel: message,
                        );
                        controllerBody.clear();
                        scrollController.animateTo(0,
                            duration: const Duration(microseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppThemes.cardDark,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(14)),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  MessageModel get message {
    MessageModel messageModel = MessageModel();
    messageModel.bodyMessage = controllerBody.text;
    messageModel.dateTime = DateTime.now().toString();
    messageModel.receiverId = widget.receiverId;
    messageModel.sanderId = SharedPref.getDate(key: 'uid');

    return messageModel;
  }
}
