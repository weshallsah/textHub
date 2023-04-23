import 'dart:convert';
import 'dart:io';

import 'package:chatbot/Notification/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Snd extends StatefulWidget {
  final RoomId;
  final NotiID;
  const Snd({this.RoomId, this.NotiID});

  @override
  State<Snd> createState() => _SndState();
}

class _SndState extends State<Snd> {
  final _controller = new TextEditingController();
  late var entermassage = '';

  void sndmassage() async {
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
    });

    var Body = {
      "to": widget.NotiID,
      "notification": {
        "body": entermassage,
        "title": user['Username'],
        "type": "Chat",
        "roomID": roomID,
      }
    };

    FirebaseFirestore.instance
        .collection('Chat')
        .doc(roomID)
        .collection('Massage')
        .add({
      'Text': entermassage,
      'Createdat': Timestamp.now(),
      'UserId': auth?.uid,
      'Username': user['Username'],
      'userProf': user['profile_img_url'],
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
      print("Response : $res");
    });

    print(roomID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: '...',
              ),
              onChanged: (value) {
                setState(() {
                  entermassage = value.trim();
                });
              },
              controller: _controller,
            ),
          ),
          IconButton(
              onPressed: () {
                print(widget.RoomId);
                entermassage.trim().isEmpty ? null : sndmassage();
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
