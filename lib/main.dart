import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texthub/Component/ChatRoom.component.dart';
import 'package:texthub/Component/compeletprofile.component.dart';
import 'package:texthub/Component/navbar.dart';
import 'package:texthub/Controller/splash.controller.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/Screen/Home_ui.dart';
import 'package:texthub/Screen/Splash_ui.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // Scaffold(
          //   body: CompeletProfile(MediaQuery.of(context).size),
          // ),
          GetBuilder<SplashController>(
        builder: (controller) {
          return Obx(() => controller.islogin.value ? Nav() : Splash());
        },
      ),
    );
  }
}
