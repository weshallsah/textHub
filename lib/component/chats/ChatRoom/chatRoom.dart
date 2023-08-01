// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../main.dart';
// import '../massage.dart';
// import '../send.dart';

// // ignore: camel_case_types
// class chatRoom extends StatefulWidget {
//   // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
//   final RoomId;
//   // ignore: prefer_typing_uninitialized_variables
//   final userPic;
//   // ignore: prefer_typing_uninitialized_variables
//   final username;
//   // ignore: prefer_typing_uninitialized_variables
//   final userID;
//   // ignore: non_constant_identifier_names, use_key_in_widget_constructors
//   const chatRoom({this.RoomId, this.userPic, this.username, this.userID});

//   @override
//   State<chatRoom> createState() => _chatRoomState();
// }

// // ignore: camel_case_types
// class _chatRoomState extends State<chatRoom> {
//   void shownotifi(String? username, String? mess) async {
//     AndroidNotificationDetails androidditail = const AndroidNotificationDetails(
//       "chatnotification",
//       "chat",
//       importance: Importance.max,
//       icon: '@message',
//       priority: Priority.max,
//     );
//     // ignore: non_constant_identifier_names, prefer_const_constructors
//     DarwinNotificationDetails IOSditail = DarwinNotificationDetails();
//     // ignore: non_constant_identifier_names
//     NotificationDetails NotiDitail =
//         NotificationDetails(android: androidditail, iOS: IOSditail);
//     await notifcation.show(1, username, mess, NotiDitail);
//   }

//   Future<void> hendelMessage(RemoteMessage message) async {
//     // print("in hendeler");
//     if (message.data['type'] == 'Chat' &&
//         message.data['roomID'] != widget.RoomId) {
//       shownotifi(message.notification?.title, message.notification?.body);
//     }
//   }

//   Future<void> getMessage() async {
//     await FirebaseMessaging.instance.setAutoInitEnabled(true);
//     FirebaseMessaging.instance.getToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//       // print("in app message ");
//       hendelMessage(remoteMessage);
//     });
//     // print('room ID IS :- ${widget.RoomId}');
//   }

//   @override
//   void initState() {
//     getMessage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // getMessage();
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       builder: (context, child) => Scaffold(
//         body: GestureDetector(
//           onHorizontalDragUpdate: (details) {
//             // Note: Sensitivity is integer used when you don't want to mess up vertical drag
//             int sensitivity = 8;
//             if (details.delta.dx > sensitivity) {
//               // Right Swipe
//               print("rigth swipe");
//               Navigator.pop(context);
//             }
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Row(
//               //   children: [
//               //     Container(
//               //       margin: EdgeInsets.only(
//               //         top: 39.h,
//               //         left: 28.w,
//               //       ),
//               //       // color: Colors.amber,
//               //       height: 40.h,
//               //       width: 40.w,
//               //       child: CircleAvatar(
//               //         // radius: 22,
//               //         backgroundColor: Colors.blueGrey,
//               //         foregroundImage: NetworkImage(
//               //             widget.userPic != null ? widget.userPic : null),
//               //       ),
//               //     ),
//               //     Container(
//               //       height: 33.h,
//               //       width: 153.w,
//               //       margin: EdgeInsets.only(
//               //         left: 6.w,
//               //         top: 39.h,
//               //       ),
//               //       child: Text(
//               //         widget.username,
//               //         style: TextStyle(
//               //           fontSize: 22.sp,
//               //           fontWeight: FontWeight.w600,
//               //           fontFamily: "Poppins",
//               //         ),
//               //       ),
//               //     )
//               //   ],
//               // ),

//               Expanded(
//                 child: Massage(
//                   ChatRoom: widget.RoomId,
//                 ),
//               ),
//               Snd(
//                 RoomId: widget.RoomId,
//                 userId: widget.userID,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        leadingWidth: 58,
        toolbarHeight: 90,
        leading: Container(
          margin: EdgeInsets.only(left: 28.w, top: 35.h),
          // color: Colors.amber,
          height: 40.h,
          width: 40.h,
          child: FittedBox(
            fit: BoxFit.cover,
            child: CircleAvatar(
              // radius: 22,
              backgroundColor: Colors.blueGrey,
              foregroundImage:
                  NetworkImage(widget.userPic != null ? widget.userPic : null),
            ),
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 35.h, left: 6.w),
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
              child: message(ChatRoom: widget.RoomId),
            ),
            Snd(RoomId: widget.RoomId, userId: widget.userID),
          ],
        ),
      ),
    );
  }
}
