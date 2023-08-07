import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class Snd extends StatefulWidget {
  final RoomId;
  final userId;
  const Snd({this.RoomId, this.userId});

  @override
  State<Snd> createState() => _SndState();
}

class _SndState extends State<Snd> {
  final _controller = new TextEditingController();
  String? NotiID;
  bool _iscursor = false;
  late var entermassage = '';
  void sndmassage() async {
    setState(() {
      entermassage = _controller.text;
    });
    final roomID = widget.RoomId;
    final auth = await FirebaseAuth.instance.currentUser;
    final user = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth?.uid)
        .get();
    _controller.clear();
    // print(roomID);
    FirebaseFirestore.instance.collection('Chat').doc(roomID).update({
      'Ismess': true,
      'Recent': DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userId)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          NotiID = snapshot.data()!['Noti_Id'];
        });
      }
    });

    var Body = {
      "to": NotiID,
      "notification": {
        "body": entermassage,
        "title": user['Username'],
        "android_channel_id": "chats",
      },
      "data": {
        "roomID": roomID,
        "type": "Chat",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      }
    };

    FirebaseFirestore.instance
        .collection('Chat')
        .doc(roomID)
        .collection('Message')
        .add({
      'Text': entermassage,
      'Createdat': Timestamp.now(),
      'isvanishTime': DateTime.now().hour,
      'isvanishDay': DateTime.now().day,
      'UserId': auth?.uid,
      'Username': user['Username'],
      'userProf': user['Avtar_URL'],
    }).then((value) {
      var res;
      try {
        res = post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(Body),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader:
                  "key=AAAARO3dPks:APA91bEbDftQ48XveBpl3S_p9WwObffxpXc6e5nlOt55PFVHKL7LaPRvJi2HIXNyzN7mXi913fvohsn-W39weZqPxqn8UAiJ_BnUXMLfVQHkQvQl9TuYGRKQTnwFbXEkHubXl8LKORqP"
            });
      } catch (err) {
        print(err);
      }
      // print("Response : $res");
    });

    // print(roomID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            // fit: ,
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 12,
              ),
              padding: EdgeInsets.all(12),
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              alignment: Alignment.center,
              child: TextField(
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
                controller: _controller,
                showCursor: _iscursor,
                onChanged: (value) {
                  setState(() {
                    if (_controller.text == "") {
                      _iscursor = false;
                    } else {
                      _iscursor = true;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: " Type Something",
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromARGB(211, 166, 166, 166),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 53,
              margin: EdgeInsets.only(
                bottom: 12,
              ),
              child: IconButton(
                onPressed: () {
                  sndmassage();
                },
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
