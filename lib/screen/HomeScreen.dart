import 'package:chatbot/component/chats/Archive.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/greetme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _fontfamily = "Poppins";
  bool _dragup = false;
  Color _color = Colors.black;
  String? userName = '';
  String? profilimage = '';
  String? myuid = '';
  String? docs;
  bool _aboutmenu = false;
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
    // _dragup = false;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(375, 812),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 71.h,
          title: Container(
            margin: EdgeInsets.only(
              left: 34.w,
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
                  onTap: () {
                    if (_dragup) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Archive(
                            Docs: docs,
                            Myuid: myuid,
                          ),
                        ),
                      );
                    } else {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: _dragup ? 107.w : 145.w,
                      // top: 40.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    height: _dragup ? 31.h : 27.h,
                    width: _dragup ? 113.w : 75.w,
                    alignment: Alignment.center,
                    child: Text(
                      _dragup ? "Archived" : "Logout",
                      style: TextStyle(
                          // color: _dragup ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: _dragup ? 20.sp : 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (!_dragup) greetme(),
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      int sensitivity = 8;
                      if (details.delta.dy > sensitivity) {
                        // Down Swipe
                        setState(() {
                          // _color = Colors.black;
                          _dragup = false;
                        });
                        print("draged down");
                      } else if (details.delta.dy < -sensitivity) {
                        // Up Swipe
                        setState(() {
                          // _color = Colors.white;
                          _dragup = true;
                        });
                        print("draged UP");
                      }
                    },
                    child: Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: chatBox(
                          drag_: _dragup,
                          Myuid: myuid,
                          docs: docs,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
