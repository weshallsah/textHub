import 'package:chatbot/Notification/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../massage.dart';
import '../send.dart';

class chatRoom extends StatefulWidget {
  final RoomId;
  final userPic;
  final username;
  final NotiID;
  const chatRoom({this.RoomId, this.userPic, this.username,this.NotiID});

  @override
  State<chatRoom> createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 30,
        leadingWidth: 95,
        leading: Container(
          // color: Colors.amber,
          child: Row(
            children: [
              IconButton(
                // padding: EdgeInsets.only(right: ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blueGrey,
                foregroundImage: NetworkImage(widget.userPic!=null?widget.userPic:null),
              )
            ],
          ),
        ),
        title: Text(widget.username ?? ""),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Massage(ChatRoom: widget.RoomId),
            ),
            Snd(RoomId: widget.RoomId,NotiID: widget.NotiID),
          ],
        ),
      ),
    );
  }
}
