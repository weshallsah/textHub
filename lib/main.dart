import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texthub/Component/Loading.component.dart';
import 'package:texthub/Controller/splash.controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Loading());
  }
}
