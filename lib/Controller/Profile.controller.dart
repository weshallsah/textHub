import 'dart:io';

import 'package:get/get.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class Profilecontroller extends GetxController {
  RxString name = "".obs;
  File? avatar;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    User? user = await AuthSrevice().getuser();
    print(user?.toMap());
    name.value = user!.name;
    avatar = File(user.avatar);
  }

  void logout() async {
    await AuthSrevice().logout();
  }
}
