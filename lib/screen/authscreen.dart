import 'package:chatbot/component/auth.dart';
import 'package:chatbot/component/chats/massage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  bool isloading = false;
  var errmassage = "";

  void _submitForm(
      String email, String password, String username, bool islogin) async {
    UserCredential Futher;
    try {
      setState(() {
        isloading = true;
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
            .set({
          'Username': username,
          'Email': email,
        });
      }
    } on PlatformException catch (err) {
      // errmassage="faillogin";
      if (err.message != null) {
        errmassage = err.message as String;
      }  
    } catch (err) {
      print(err);
      setState(() {
        isloading = !isloading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple.shade200,
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
        body: Authfrom(_submitForm, isloading,errmassage),
      ),
    );
  }
}
