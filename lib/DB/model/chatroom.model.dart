class Chatroom {
  String uid;
  String sender;
  String rechiver;
  String message;
  DateTime dateTime;
  Chatroom(this.uid, this.sender, this.message, this.dateTime, this.rechiver);

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "sender": sender,
      "reciver": rechiver,
      "message": message,
      "DateTime": dateTime,
    };
  }

  String toString() {
    return "uid:${uid}, sender:${sender} , rechiver:${rechiver}, message:${message}, datetime:${dateTime}";
  }
}
