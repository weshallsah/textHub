import 'package:chatbot/component/Auth/auth.dart';
import 'package:chatbot/component/Auth/uploadAvtar.dart';
import 'package:chatbot/component/Auth/verify.dart';
import 'package:chatbot/screen/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'component/theme/theme.dart';

FlutterLocalNotificationsPlugin notifcation = FlutterLocalNotificationsPlugin();
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

  await notifcation.initialize(initializationSettings);

  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'message Nofication',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chat',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController URL = TextEditingController(
      text:
          "https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2Fcommanprofileavtar.png?alt=media&token=b9791391-f85a-4e01-be99-ae7fd7f0dd7d");
  bool iscomplete = true;
  void check(bool istrue) {
    setState(() {
      iscomplete = istrue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      scaleByHeight: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.LigthTheme,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.emailVerified) {
                  print(iscomplete);
                  if (iscomplete) {
                    return Home();
                  }
                  return chooseAvtar(check, false, URL);
                }
                return verify();
              }
              return Auth(check);
            },
          ),
        );
      },
    );
  }
}
