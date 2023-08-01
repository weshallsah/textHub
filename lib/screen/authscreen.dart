import 'dart:async';

import 'package:chatbot/component/Auth/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// late MediaQueryData queryData;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  var isloading = false;
  bool islogin = false;

  // ignore: non_constant_identifier_names

  void _submitForm(String Firstname, String Lastname, String email,
      String password, String username) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    // ignore: non_constant_identifier_names
    UserCredential Futher;
    // var imgurl;
    try {
      setState(() {
        isloading = !isloading;
      });
      if (islogin) {
        Futher = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(Futher.user?.uid)
            .update({
          'Noti_Id': fcmToken,
        });
      } else {
        Futher = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(Futher.user?.uid)
            .set(
          {
            'Noti_Id': fcmToken,
            'firstname': Firstname,
            'lastname': Lastname,
            'Username': username,
            'Email': email,
            'profile_img_url':
                "https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2Fcommanprofileavtar.png?alt=media&token=b9791391-f85a-4e01-be99-ae7fd7f0dd7d",
            'uid': Futher.user?.uid,
            'isvarify': false,
          },
        ).whenComplete(() => null);
      }
    } on PlatformException catch (err) {
      var errMassage = "please enter valid cerdential";
      if (err.message != null) {
        errMassage = err.message as String;
        SnackBar(
          content: Text(
            errMassage,
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    } catch (err) {
      print(err);
    }
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
      body: Authfrom(_submitForm, isloading, islogin),
    );
  }
}
