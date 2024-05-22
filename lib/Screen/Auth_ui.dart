import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:texthub/Component/compeletprofile.component.dart';
import 'package:texthub/Component/navbar.dart';
import 'package:texthub/Component/otp.component.dart';
import 'package:texthub/Component/phone.component.dart';
import 'package:texthub/Controller/Auth.controller.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/DB/constant/cc.constant.dart';

class Auth extends StatelessWidget {
  Auth({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Obx(() {
            if (controller.page.value == 1) {
              return VerifyOTP(size);
            } else if (controller.page.value == 2) {
              return CompeletProfile(size);
            } else {
              return SendOTP(size);
            }
          });
        },
      ),
    );
  }
}
