
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';
import '../message.dart';
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
  const chatRoom({this.RoomId, this.userPic, this.username, this.userID});

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
    if (message.data['type'] == 'Chat' &&
        message.data['roomID'] != widget.RoomId) {
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
        // leadingWidth: 30,
        automaticallyImplyLeading: false,

        leading: Container(
          // color: Colors.amber,
          // height: 40,
          margin: EdgeInsets.only(
            left: 14,
          ),
          child: Image(
            image: NetworkImage(
              widget.userPic,
            ),
          ),
        ),
        title: Container(
          child: Text(
            widget.username,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              print("rigth swipe");
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: message(
                  ChatRoom: widget.RoomId,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Snd(
                RoomId: widget.RoomId,
                userId: widget.userID,
              ),
            ],
          )),
    );
  }
}
