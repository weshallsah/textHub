import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class verify extends StatefulWidget {
  const verify({super.key});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  final auth = FirebaseAuth.instance.currentUser;
  bool ischeck = false;
  void sendlink() async {
    auth?.sendEmailVerification();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth?.reload().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    auth?.reload().then((value) {
      setState(() {});
    });
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
                padding: const EdgeInsets.all(0),
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
            margin: const EdgeInsets.only(
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
            margin: const EdgeInsets.only(
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
              margin: const EdgeInsets.only(
                top: 140,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(41),
                  topRight: Radius.circular(41),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!ischeck)
                      Text(
                        "Get Mail verification",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    if (ischeck)
                      Text(
                        "Verfication Mail is sended",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ischeck = true;
                        });
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        maximumSize: MaterialStatePropertyAll(
                          Size(300, 97),
                        ),
                        minimumSize: MaterialStatePropertyAll(
                          Size(160, 55),
                        ),
                      ),
                      child: Text(ischeck ? "Resend Mail" : "Send Mail"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
