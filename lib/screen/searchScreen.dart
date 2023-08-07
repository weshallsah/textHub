import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

final ChatId = const Uuid();

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController Searchuser = TextEditingController();
  String? ChatRoomid;

  void getchatRoom(
      String uid, String username, String Pic, String notiID) async {
    final myuid = FirebaseAuth.instance.currentUser?.uid;
    final Room = await FirebaseFirestore.instance
        .collection('Chat')
        .where('FrndConver.${uid}', isEqualTo: true)
        .where('FrndConver.${myuid}')
        .get();
    if (myuid == uid) {
      var keycnt;

      Room.docs[0].data().forEach(
        (key, value) {
          if (key == uid) {
            keycnt++;
          }
        },
      );
      if (keycnt == 2) {
        ChatRoomid = Room.docs[0].data()['ChatRoomId'];
      } else {
        ChatRoomid = ChatId.v1();
        await FirebaseFirestore.instance
            .collection('Chat')
            .doc(ChatRoomid)
            .set({
          'Username': username,
          'ProfImg': Pic,
          'Recent': DateTime.now(),
          'ChatRoomId': ChatRoomid,
          'Ismess': false,
          'isArchive': false,
          'FrndConver': {
            uid: true,
            myuid: true,
          },
        });
      }
    } else if (Room.docs.length > 0) {
      ChatRoomid = await Room.docs[0].data()['ChatRoomId'];
    } else {
      ChatRoomid = ChatId.v1();
      await FirebaseFirestore.instance.collection('Chat').doc(ChatRoomid).set({
        'Username': username,
        'ProfImg': Pic,
        'ChatRoomId': ChatRoomid,
        'Recent': DateTime.now(),
        'Ismess': false,
        'isArchive': false,
        'FrndConver': {
          uid: true,
          myuid: true,
        },
      });
      // print("get in chatid");
      // print(ChatRoomid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 71.h,
        leadingWidth: 0.w,
        leading: Container(),
        elevation: 0,
        // leading: Icon(Icons.dot),
        title: Container(
          margin: EdgeInsets.only(
            left: 24.w,
            top: 40.h,
          ),
          width: 313.w,
          height: 70.h,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(0),
                // margin: EdgeInsets.only(
                //   top: 40.h,
                //   left: 34.w,
                // ),
                child: Text(
                  "Text",
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().toString(),
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 4.w,
                  // top: 40.h,
                ),
                height: 30.h,
                width: 43.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: _dragup ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(4.r)),
                alignment: Alignment.center,
                child: Text(
                  "Hub",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().toString(),
                    fontSize: 20.sp,
                  ),
                ),
              ),
              GestureDetector(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  margin: EdgeInsets.only(left: 107.w),
                  height: 31.h,
                  width: 99.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Archive",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().toString(),
                    ),
                  ),
                ),
              ),
            ],
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
            Container(
              child: Column(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                      top: 30.h,
                      left: 29.w,
                      right: 28.w,
                    ),
                    alignment: Alignment.center,
                    height: 48.h,
                    width: 318.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid,
                        )
                        // color: Colors.amber,
                        ),
                    child: TextField(
                      controller: Searchuser,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: GoogleFonts.poppins().toString(),
                          fontWeight: FontWeight.w700,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 19.h),
            // if(Searchuser.text==)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where("Username", isEqualTo: Searchuser.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        final searchuser = snapshot.data?.docs;
                        if (searchuser != null && searchuser.length > 0) {
                          print(searchuser);
                          return ListView.builder(
                            itemCount: searchuser.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 13.w, top: 22.h),
                                child: ListTile(
                                  leading: Container(
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      foregroundImage: NetworkImage(
                                          searchuser[index]['Avtar_URL']),
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 33.h,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          searchuser[index]['Username'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: GoogleFonts.poppins()
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 23.h,
                                        child: Text(
                                          "Recent massage",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: GoogleFonts.poppins()
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    await Future(
                                      () => getchatRoom(
                                          searchuser[index]['uid'],
                                          searchuser[index]['Username'],
                                          searchuser[index]['Avtar_URL'],
                                          searchuser[index]['Noti_Id']),
                                    );
                                    // print("checking before chatroom");
                                    // print(ChatRoomid);
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously

                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => chatRoom(
                                          RoomId: ChatRoomid,
                                          username: searchuser[index]
                                              ['Username'],
                                          userPic: searchuser[index]
                                              ['Avtar_URL'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          Container();
                        }
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                        child: Text(
                          "no user found",
                          style: TextStyle(fontSize: 28),
                        ),
                      );
                      // return const Text();
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
