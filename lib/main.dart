import 'package:chatbot/Nev/nevbar.dart';
import 'package:chatbot/component/chats/massage.dart';
import 'package:chatbot/landingpage/landingpage.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:chatbot/screen/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'component/chats/massagepop.dart';
// import 'dart:async';

FlutterLocalNotificationsPlugin notifcation = FlutterLocalNotificationsPlugin();
// late double screenwidth,screenhight;
// late MediaQueryData queryData;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@message');

  DarwinInitializationSettings initializationSettingsIos =
      const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    requestCriticalPermission: true,
    // onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIos,
  );

  bool? initialized = await notifcation.initialize(initializationSettings);

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'message Nofication',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chat',
  );
  // print(result);
  // print(initialized);
    // queryData = MediaQuery.of(context as BuildContext);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return chatBox();
              return NevBar();
            }
            return const RegisterScreen();
          }),
    );
  }
}
