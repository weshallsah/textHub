import 'package:chatbot/Notification/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../massage.dart';
import '../send.dart';

class chatRoom extends StatefulWidget {
  final RoomId;
  final userPic;
  final username;
  const chatRoom({this.RoomId, this.userPic, this.username});

  @override
  State<chatRoom> createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {

  @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: CircleAvatar(
        //   radius: 5,
        //   backgroundImage: userPic!=null?NetworkImage(userPic):null,
        // ),

        title: Text(widget.username),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Massage(ChatRoom: widget.RoomId),
            ),
            Snd(RoomId: widget.RoomId),
          ],
        ),
      ),
    );
  }
}
