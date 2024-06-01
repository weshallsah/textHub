import 'dart:io';

class User {
  String uid;
  String name;
  String phone;
  String email;
  var avatar;
  User(
      {required this.uid,
      required this.name,
      required this.phone,
      required this.email,
      required this.avatar});

  void fromJson(Map<String, dynamic> object) {
    uid = object["_id"];
    name = object['name'];
    phone = object['phone'];
    email = object['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "email": email,
      "avatar": avatar,
    };
  }

  String toString() {
    return "user{uid:${uid}, name:${name}, phone:${phone}, email:${email}}";
  }
}
