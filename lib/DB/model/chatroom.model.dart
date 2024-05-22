class Chatroom {
  int uid;
  int phone;
  String message;
  DateTime dateTime;
  Chatroom(this.uid, this.phone, this.message, this.dateTime);

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "phone": phone,
      "message": message,
      "DateTime": dateTime,
    };
  }

  String toString() {
    return "uid:${uid}, phone:${phone}, message:${message}, datetime:${dateTime}";
  }
}
