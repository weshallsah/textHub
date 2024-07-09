import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/DB/model/chatroom.model.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class ChatController extends GetxController {
  RxList chat = [].obs;
  late IO.Socket socket;
  RxBool ismenu = false.obs;
  TextEditingController message = TextEditingController();
  User friend;
  ChatController(this.socket, this.friend);
  late final user;
  void getchats() async {
    try {
      chat = await DBcontroller().fetchChats(friend);
      print("chat fetchs :- ${chat}");
    } catch (e) {
      print("error :- ${e}");
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    user = await AuthSrevice().getuser();
    getchats();
    super.onInit();
    print(socket);
    final res = await socket.connect();
    print("res :- ${socket}");
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    // print(user.phone);
    socket.on("message", (data) {
      // print(data);
      // for (var element in data) {
      //   DBcontroller().InsertChart(Chat(element._id, element.sender,
      //       element.message, element.createdAt, element.receiver));
      // }
      chat.refresh();
    });
    socket.on("ackrequest", (data) {
      print("acknowlegment is here");
      socket.emit("ackresponse", "yes im ready");
    });
  }

  void send() {
    print(user);
    print(message.text);
    print(friend);
    socket.emit("chat", {
      "sender": user.phone,
      "receiver": friend.phone,
      "message": message.text
    });
    message.clear();
  }
}
