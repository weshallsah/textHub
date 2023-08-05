import 'package:chatbot/component/Auth/uploadAvtar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class verify extends StatefulWidget {
  const verify({super.key});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  final auth = FirebaseAuth.instance.currentUser;
  void sendlink() async {
    auth?.sendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    
    auth?.reload();
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
            margin: EdgeInsets.only(
              top: 149,
              left: 39,
            ),
            child: Text(
              "Email Verification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
              ),
            ),
          ),
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(
              left: 39,
            ),
            child: Text(
              "Email has been Verified.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 140,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(41),
                  topRight: Radius.circular(41),
                ),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  sendlink();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 115,
                    horizontal: 35,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Email verify",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
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
