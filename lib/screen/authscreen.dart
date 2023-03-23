import 'package:chatbot/component/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  var isloading = false;

  // ignore: non_constant_identifier_names
  void uploadimg(File? ProfImg) async {
    if (ProfImg != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('Profile_Img')
          .child('${_auth.currentUser?.uid}.jpg');
      await ref.putFile(ProfImg);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(_auth.currentUser?.uid)
          .set(
        {
          'ProfImgurl': ref.getDownloadURL(),
        },
      );
    }
  }

  void _submitForm(String email, String password, String username, bool islogin,
      File? Img) async {
    // ignore: non_constant_identifier_names
    UserCredential Futher;
    try {
      setState(() {
        isloading = !isloading;
      });
      if (islogin) {
        Futher = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Futher = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(Futher.user?.uid)
            .set(
          {
            'Username': username,
            'Email': email,
          },
        );
        uploadimg(Img);
      }
    } on PlatformException catch (err) {
      // ignore: unused_local_variable
      var errMassage = "please enter valid cerdential";
      if (err.message != null) {
        errMassage = err.message as String;
      }
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.blueGrey.shade400),
          ),
        ),
      ),
      home: Scaffold(
        body: Authfrom(_submitForm, isloading),
      ),
    );
  }
}
