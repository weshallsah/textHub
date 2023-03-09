import 'package:chatbot/screen/ChatBox.dart';
import 'package:chatbot/screen/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot){
        if(snapshot.hasData){
          return const ChatBox();
        }
        return const RegisterScreen();
      }),
    );
  }
}
