import 'package:chat/model/user_model.dart';
import 'package:chat/shard_prf/SharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  createUser(UserModel userModel) async {
    return await fireStore
        .collection('users').doc(userModel.uid)
        .set(userModel.toMap())
        .then((value) {
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<UserModel>> getUsers() async* {
    yield* fireStore
        .collection('users')
        .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromMep(snapshot.data()!),
            toFirestore: (UserModel value, options) => value.toMap()).where('uid',isNotEqualTo: SharedPref.getDate(key: 'uid'))
        .snapshots();
  }
  Stream<QuerySnapshot<UserModel>> getCurrentUser() async* {
    yield* fireStore
        .collection('users')
        .withConverter<UserModel>(
        fromFirestore: (snapshot, options) =>
            UserModel.fromMep(snapshot.data()!),
        toFirestore: (UserModel value, options) => value.toMap()).where('uid',isEqualTo: SharedPref.getDate(key: 'uid'))
        .snapshots();
  }



}






