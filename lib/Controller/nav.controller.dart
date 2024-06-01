import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:texthub/Component/Loading.component.dart';
import 'package:texthub/Component/adduser.component.dart';
import 'package:texthub/Screen/Home_ui.dart';
import 'package:texthub/Screen/Story_ui.dart';
import 'package:texthub/Screen/calls_ui.dart';
import 'package:texthub/Screen/profile_ui.dart';

class NavController extends GetxController {
  RxList page = [Home(), Story(), Calls(), Profile()].obs;
  RxInt idx = 0.obs;
  RxString current = "Chat".obs;
  // RxList contact = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // contact = (ContactsService.getContacts()) as RxList;
  }

  Widget loadpage() {
    return page[idx.value];
  }

  Future<bool> getpermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status != PermissionStatus.granted) {
      return await Permission.contacts.request() == PermissionStatus.granted;
    }
    return status == PermissionStatus.granted;
  }

  void adduser() async {
    final status = await getpermission();
    print(status);
    if (status) {
      Get.to(() => Loading());
      List contact = await FlutterContacts.getContacts(
          withThumbnail: true, deduplicateProperties: false);
      var avatar = {};
      var userphone = {};
      for (var user in contact) {
        // File? file;

        if (user.thumbnail != null) {
          final tempDir = await getTemporaryDirectory();
          avatar[user.id] =
              await File('${tempDir.path}/${user.displayName}.png').create();
          avatar[user.id].writeAsBytesSync(user.thumbnail);
        }
        // avatar[user.id] = file;
        final phone = await FlutterContacts.getContact(user.id);
        userphone[user.id] = phone?.phones[0].number;
      }
      Get.back();
      Get.to(() => Adduser(
            content: contact,
            avatar: avatar,
            phone: userphone,
          ));
    }
  }
}
