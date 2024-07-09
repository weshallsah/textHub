class User {
  String name;
  String phone;
  var avatar;
  User({required this.name, required this.phone, required this.avatar});

  void fromJson(Map<String, dynamic> object) {
    name = object['name'];
    phone = object['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "avatar": avatar,
    };
  }

  String toString() {
    return "user{name:${name}, phone:${phone}, avatar:${avatar}}";
  }
}
