import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../main.dart';
import '../massage.dart';
import '../send.dart';

// ignore: camel_case_types
class chatRoom extends StatefulWidget {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  final RoomId;
  // ignore: prefer_typing_uninitialized_variables
  final userPic;
  // ignore: prefer_typing_uninitialized_variables
  final username;
  // ignore: prefer_typing_uninitialized_variables
  final userID;
  // ignore: non_constant_identifier_names, use_key_in_widget_constructors
  const chatRoom({this.RoomId, this.userPic, this.username,this.userID});

  @override
  State<chatRoom> createState() => _chatRoomState();
}

// ignore: camel_case_types
class _chatRoomState extends State<chatRoom> {

  void shownotifi(String? username, String? mess) async {
    AndroidNotificationDetails androidditail = const AndroidNotificationDetails(
      "chatnotification",
      "chat",
      importance: Importance.max,
      icon: '@message',
      priority: Priority.max,
    );
    // ignore: non_constant_identifier_names, prefer_const_constructors
    DarwinNotificationDetails IOSditail = DarwinNotificationDetails();
    // ignore: non_constant_identifier_names
    NotificationDetails NotiDitail =
        NotificationDetails(android: androidditail, iOS: IOSditail);
    await notifcation.show(1, username, mess, NotiDitail);
  }

  Future<void> hendelMessage(RemoteMessage message) async {
    // print("in hendeler");
    if (message.data['type'] == 'Chat' && message.data['roomID'] != widget.RoomId){
      shownotifi(message.notification?.title, message.notification?.body);
    }
  }

  Future<void> getMessage() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      // print("in app message ");
        hendelMessage(remoteMessage);
        
    });
    // print('room ID IS :- ${widget.RoomId}');
  }
  @override
  void initState() {
    getMessage();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    // getMessage();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white54,
        foregroundColor: Colors.black,
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
            Snd(RoomId: widget.RoomId,userId: widget.userID),
          ],
        ),
      ),
    );
  }
}
