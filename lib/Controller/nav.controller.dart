import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:texthub/Component/ChatRoom.component.dart';
import 'package:texthub/Component/Loading.component.dart';
import 'package:texthub/Component/adduser.component.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/DB/model/chatroom.model.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Screen/Home_ui.dart';
import 'package:texthub/Screen/Story_ui.dart';
import 'package:texthub/Screen/calls_ui.dart';
import 'package:texthub/Screen/profile_ui.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:texthub/Srevice/Auth.Srevice.dart';
import 'package:sqflite/sqflite.dart';
import 'package:texthub/DB/constant/DBName.constant.dart';

class NavController extends GetxController {
  // RxList page = [Home, Story, Calls, Profile].obs;
  RxInt idx = 0.obs;
  RxString current = "Chat".obs;
  User? user;
  List users = [].obs;
  RxBool issocket = false.obs;
  late IO.Socket socket;
  late Database db;
  void connectSocket() async {
    print("socket is intializing");
    socket = await IO.io(
      "https://zk29l5cf-9000.inc1.devtunnels.ms/",
      // "http://10.0.2.2:9000/",
      <String, dynamic>{
        "autoConnect": true,
        'transports': ['websocket'],
      },
    );
    final res = await socket.connect();
    print("res :- ${socket}");
    socket.onConnect((_) {
      issocket.value = true;
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    print(user);
    socket.emit("joinchat", {"phone": user?.phone.toString()});
    socket.on("message", (data) {
      try {
        for (var el in data) {
          Chat chat = Chat(el['_id'], el['sender'], el['message'],
              el['createdAt'], el['receiver']);
          print(chat.toString());
          DBcontroller().InsertChart(chat);
        }
      } catch (e) {
        print("error in rechiving :- ${e}");
      }

      // for (var e in data) {
      //   Chat chat = Chat(e._id, e.sender, e.message, e.createdAt, e.receiver);
      //   print(chat);
      // }
      // for (var element in data) {
      //   DBcontroller().InsertChart(Chat(element._id, element.sender,
      //       element.message, element.createdAt, element.receiver));
      // }
    });
    socket.on("ackrequest", (data) {
      print("acknowlegment is here");
      socket.emit("ackresponse", {"receiver": user?.phone.toString()});
    });
  }

  @override
  void onInit() async {
    super.onInit();
    user = await AuthSrevice().getuser();
    connectSocket();
    final path = await DBname();
    db = await openDatabase(path);
    final status = await getpermission();
    print(status);
    if (status) {
      final contact;
      contact = await FlutterContacts.getContacts(
          withThumbnail: true, deduplicateProperties: false);
      for (var u in contact) {
        User user = User(name: u.displayName, phone: "", avatar: "");
        if (u.thumbnail != null) {
          final tempDir = await getTemporaryDirectory();
          user.avatar =
              await File('${tempDir.path}/${u.displayName}.png').create();
          user.avatar.writeAsBytesSync(u.thumbnail);
        }
        final phone = await FlutterContacts.getContact(u.id);
        user.phone = phone!.phones[0].number;
        user.phone = user.phone.replaceAll(' ', '');
        user.phone = user.phone.replaceAll('(', '');
        user.phone = user.phone.replaceAll(')', '');
        user.phone = user.phone.replaceAll('-', '');
        users.add(user);
      }
    }
  }

  Widget loadpage() {
    switch (idx) {
      case 1:
        return Story();
      case 2:
        return Calls();
      case 3:
        return Profile();
      // break;
      default:
        return Home(socket, db);
    }
  }

  Future<bool> getpermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status != PermissionStatus.granted) {
      return await Permission.contacts.request() == PermissionStatus.granted;
    }
    return status == PermissionStatus.granted;
  }

  void adduser(User user) async {
    DBcontroller().InsertUser(user);
    if (user.avatar != "") {
      // user.avatar = await user.avatar.readAsBytes();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/${user.name}.png').create();
      file.writeAsBytesSync(await user.avatar.readAsBytes());
      user.avatar = file;
    }
    Get.to(() => ChatRoom(user, socket));
    // await
  }

  void userlist(NavController navController) async {
    Get.to(() => Adduser(
          users: users,
          navController: navController,
        ));
  }
}
