import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:texthub/Screen/Home_ui.dart';
import 'package:texthub/Screen/Story_ui.dart';
import 'package:texthub/Screen/calls_ui.dart';
import 'package:texthub/Screen/profile_ui.dart';

class NavController extends GetxController {
  RxList page = [Home(), Story(), Calls(), Profile()].obs;
  RxInt idx = 0.obs;
  RxString current = "Chat".obs;
  Widget loadpage() {
    return page[idx.value];
  }
}
