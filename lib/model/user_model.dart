class UserModel {
  late String email;
  late String uid;
  late dynamic image='';

  UserModel();

  UserModel.fromMep(Map<String, dynamic> map) {
    email = map['email'];
    uid=map['uid'];
  image= map['image'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['email'] = email;
    map['uid']=uid;

    return map;
  }
}
