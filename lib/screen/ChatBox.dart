import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/component/profile/profile.dart';
import 'package:chatbot/screen/searchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../component/chats/frendprev.dart';

class chatBox extends StatefulWidget {
  chatBox();

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  String? userName = '';
  String? profilimage = '';
  String? myuid = '';
  String? docs;
  // Map<String,dynamic>? Frindid;
  String? roomId;

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
            profilimage = snapshot.data()!['profile_img_url'];
            myuid = snapshot.data()!['uid'];
          });
        }
      },
    );
    docs = 'FrndConver.${myuid}';
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
    // String _Date = DateFormat.LLL().toString();
    // print(DateFormat.d().format(DateTime.now()));
    final screensize = MediaQuery.of(context).size;
    // final logohigh = ,
    //     logowidth = ;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          int sensitivity = 8;
          if (details.delta.dx > sensitivity) {
            // Right Swipe
          } else if (details.delta.dx < -sensitivity) {
            //Left Swipe
          }
        },
        child: SafeArea(
          // color: Colors.amber,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(
                        top: screensize.height * 0.05,
                        left: screensize.width * 0.08),
                    height: screensize.height * 0.03,
                    width: screensize.width * 0.26,
                    child: Row(
                      children: [
                        const Text(
                          "Text ",
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          height: screensize.height * 0.04,
                          width: screensize.width * 0.14,
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(9)),
                          child: const Text(
                            "Hub",
                            style: TextStyle(
                              fontFamily: "poppins",
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: screensize.width * 0.30,
                      height: screensize.height * 0.038,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          // backgroundBlendMode: /,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      margin: EdgeInsets.only(
                        top: screensize.height * 0.049,
                        left: screensize.width * 0.29,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      child: const Text(
                        "Archived",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(
                  top: screensize.height * 0.03,
                  left: screensize.width * 0.07,
                ),
                height: screensize.height * 0.059,
                width: screensize.width * 0.58,
                // color: Colors.amber,
                alignment: Alignment.center,
                child: const FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  child: Text(
                    "Recent Chats",
                    style: TextStyle(
                      fontSize: (48),
                      fontWeight: FontWeight.bold,
                      fontFamily: "poppins",
                    ),
                  ),
                ),
              ),
              // prev(),
              Container(
                // padding: EdgeInsets.all(0),
                child: Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Chat')
                        .where(docs.toString(), isEqualTo: true)
                        .where("Ismess", isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final FrndList = snapshot.data?.docs;
                        if (FrndList != null && FrndList.length > 0) {
                          return ListView.builder(
                              itemCount: FrndList.length,
                              itemBuilder: (context, index) {
                                Map Frindid = FrndList[index]['FrndConver'];
                                String? uid;
                                Frindid.forEach(
                                  (key, value) => {
                                    if (key != myuid) {uid = key}
                                  },
                                );
                                return prev(
                                  FrndList[index]['Username'],
                                  FrndList[index]['ProfImg'],
                                  FrndList[index]['ChatRoomId'],
                                  uid,
                                );
                              });
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const searchPage(),
      //       ),
      //     );
      //     // shownotifi("vishal", "hello");
      //     // LocalNotification().shownotification("title", "body", 'item x');
      //   },
      //   child: const Icon(
      //     Icons.add,
      //   ),
      // ),
    );
  }
}
