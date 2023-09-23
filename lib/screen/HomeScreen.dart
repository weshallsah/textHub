import 'package:chatbot/component/chats/Archive.dart';
import 'package:chatbot/component/greetme.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userName = '';
  TextEditingController profilimage = TextEditingController();
  String? myuid = '';
  String? docs;
  String? roomId;
  bool isup = false;

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            userName = snapshot.data()!['Username'];
            profilimage.text = snapshot.data()!['Avtar_URL'];
            myuid = snapshot.data()!['uid'];
          });
        }
      },
    );
    docs = 'FrndConver.$myuid';
    // print('geting data: $docs');
  }

  @override
  void initState() {
    getData();
    // getMessage();

    super.initState();
  }

  // void _isedited(bool isEdit) {
  //   getData();
  // }

  String RoomID = '';

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Text",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Hub",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        // titleSpacing: double.infinity,

        actions: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Archive(
                      Docs: docs,
                      Myuid: myuid,
                    ),
                  ),
                );
              },
              child: Container(
                // height: 27,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(
                  right: 21,
                  bottom: 11,
                  top: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  "Archived",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;

          if (details.delta.dy > sensitivity) {
            setState(
              () {
                // print("isup");
                isup = false;
              },
            );
          } else if (details.delta.dy < -sensitivity) {
            setState(
              () {
                // print("object");
                isup = true;
              },
            );
            // }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isup) greetme(profilimage, userName),
            chatBox(drag_: isup, docs: docs, Myuid: myuid),
          ],
        ),
      ),
    );
  }
}
