import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String bodyMessage;
  late String dateTime;
  late String sanderId;
  late String receiverId;

  MessageModel();

  MessageModel.fromMap( map) {
    bodyMessage = map['bodyMessage'];
    dateTime = map['dateTime'];
    sanderId = map['sanderId'];
    receiverId = map['receiverId'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['bodyMessage'] = bodyMessage;
    map['dateTime'] = dateTime;
    map['sanderId'] = sanderId;
    map['receiverId'] = receiverId;
    return map;
  }
}