import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class verify extends StatefulWidget {
  const verify({super.key});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  void sendlink() async {
    final auth = FirebaseAuth.instance.currentUser;
    auth?.sendEmailVerification().then(
      (value) async {
        await FirebaseFirestore.instance.collection('user').doc(auth.uid).update(
          {
            'isvarify': true,
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: Theme.of(context).textTheme.titleMedium,
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
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(
              top: 149.h,
              left: 39.w,
            ),
            width: 251.w,
            height: 42.h,
            child: Text(
              "Email Verification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                fontFamily: GoogleFonts.poppins().toString(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              // top: 149.h,
              left: 39.w,
            ),
            width: 157.w,
            height: 20.h,
            alignment: Alignment.topLeft,
            child: Text(
              "Get Email Verified.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                fontFamily: GoogleFonts.poppins().toString(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              sendlink();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(41),
                  topRight: Radius.circular(41),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              margin: EdgeInsets.only(
                top: 150.h,
              ),
              alignment: Alignment.center,
              height: 340.h,
              width: 375.w,
              child: Center(
                child: Container(
                  height: 97.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Email Verified",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().toString(),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
