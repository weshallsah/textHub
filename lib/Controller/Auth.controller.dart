import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class AuthController extends GetxController {
  TextEditingController code = TextEditingController(text: "+91");
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  RxList otps = [].obs;
  RxBool isclecked = false.obs;
  RxInt page = 0.obs;
  var avatar;
  XFile? image;
  RxBool isavatar = false.obs;

  void completeprofile() async {
    isclecked.value = true;
    print("phone :- ${phone.text}");
    print("name ${name.text}");
    if (name.text.trim() == "") {
      isclecked.value = false;
      return;
    }
    var request = http.MultipartRequest(
      'Post',
      Uri.parse("https://zk29l5cf-9000.inc1.devtunnels.ms/api/login"),
    );
    request.fields['name'] = name.text;
    request.fields['phone'] = phone.text;
    print(image?.path);
    if (image?.path != null) {
      http.MultipartFile file = await http.MultipartFile.fromPath(
        'avatar',
        image!.path,
      );
      request.files.add(file);
    }

    var payload;
    await request.send().then((streamres) async {
      print(streamres);
      final res = await http.Response.fromStream(streamres);
      print(res.body);
      payload = jsonDecode(res.body);
    });
    print("payload := ${payload}");
    if (payload['status'] == 200) {
      print(avatar.path);
      final res = payload['payload'];
      User user = User(
        name: res['name'],
        phone: res['phone'],
        avatar: avatar.path,
      );
      print("user from model :- ${user.toMap()}");
      await AuthSrevice().setlogin(user);
      print(await AuthSrevice().islogin());
    } else {
      isclecked.value = false;
    }
    isclecked.value = false;
  }

  void Getotp() async {
    isclecked.value = true;
    print("code ${code.text}");
    print("phone ${phone.text}");
    if (phone.text.trim() == "") {
      isclecked.value = false;
      return;
    }
    final payload = await http.get(Uri.parse(
        "https://zk29l5cf-9000.inc1.devtunnels.ms/api/user/${code.text}/${phone.text}"));
    print(jsonDecode(payload.body)['status']);

    if (jsonDecode(payload.body)['status'] == 200) {
      // Get.to(() => Nav());
      page.value = 1;
    }
    isclecked.value = false;
  }

  void verify() async {
    isclecked.value = true;
    print("phone :- ${phone.text}");
    print("opt length :- ${otps.length}");
    String text = "";
    if (otps.length == 0) {
      isclecked.value = false;
      return;
    }
    for (String otp in otps) {
      print("otp :- ${otp}");
      if (otp.trim() == "") {
        isclecked.value = false;
        return;
      }
      text = text + otp;
    }
    print("otp :- ${text}");
    final payload = await http.get(Uri.parse(
        "https://zk29l5cf-9000.inc1.devtunnels.ms/api/verify/${phone.text}/${text}"));
    // print(payload.body);
    print(jsonDecode(payload.body)['status']);
    final res = jsonDecode(payload.body);
    if (res['status'] == 200) {
      if (res['payload'] != null) {
        print(res['payload']);
        name.text = res['payload']['name'];
        if (res['payload']['avatar'] != null&&res['payload']['avatar'] != "") {
          final tempDir = await getTemporaryDirectory();
          http.Response response =
              await http.get(Uri.parse(res['payload']['avatar']));
          File file =
              await File('${tempDir.path}/${res['payload']['name']}.png')
                  .create();
          file.writeAsBytesSync(response.bodyBytes);
          // print("file :- ${file}");
          avatar = File(file.path);
          isavatar.value = true;
        }
        // print(avatar);
      }
      isclecked.value = false;
      page.value = 2;
    } else {
      isclecked.value = false;
    }
  }

  void check() {
    print("goback");
    page.value = 0;
    page.refresh();
  }

  void imagepick() async {
    final ImagePicker imagePicker = ImagePicker();
    image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    ) as XFile;
    avatar = File(image!.path);
    if (avatar != null) {
      isavatar.value = true;
    }
  }
}
