class Chat {
  String uid;
  String sender;
  String receiver;
  String message;
  String createdAt;
  Chat(this.uid, this.sender, this.message, this.createdAt, this.receiver);

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "sender": sender,
      "reciver": receiver,
      "message": message,
      "createdAt": createdAt,
    };
  }

  String toString() {
    return "uid:${uid}, sender:${sender} , rechiver:${receiver}, message:${message}, datetime:${createdAt}";
  }
}
