import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:texthub/Controller/Home.controller.dart';
import 'package:texthub/DB/constant/DBName.constant.dart';
import 'package:texthub/DB/model/chatroom.model.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DBcontroller {
  late Database db;
  void Createdb() async {
    try {
      final path = await DBname();
      db = await openDatabase(path, version: 1);
      await db.execute('''
              CREATE TABLE users (
                phone Text primary key,
                name Text not null,
                avatar Blob
              )''');
      await db.execute('''
              CREATE TABLE chats(
                uid text primary key,
                sender text not null,
                reciver text not null,
                message text not null,
                createAt text not null
              )''');
      print("table is created ${db}");
    } catch (e) {
      print("error :- ${e}");
    }
  }

  Future InsertUser(User user) async {
    try {
      final path = await DBname();
      Database db = await openDatabase(path);
      final istable = await db.query("sqlite_master", columns: ['name']);
      bool iscreate = true;
      istable.forEach((element) {
        if (element['name'] == 'users') {
          iscreate = false;
        }
      });
      if (iscreate) {
        await db.execute('''
              CREATE TABLE users (
                phone Text primary key,
                name Text not null,
                avatar Blob
              )''');
      }
      var avatar;
      if (user.avatar != "") {
        avatar = await user.avatar.readAsBytes();
      }
      await db.insert(
          'users', {"phone": user.phone, "name": user.name, "avatar": avatar});
      print("done");
      Homecontroller(IO.io("")).onInit();
    } catch (e) {
      print("error :- ${e}");
    }
  }

  Future fetchusers() async {
    try {
      List<User> users = [];
      final path = await DBname();
      Database db = await openDatabase(path);
      final res = await db.query("users");
      for (var u in res) {
        // print(u);
        File? file;
        if (u['avatar'] != "" && u['avatar'] != null) {
          final temp = await getTemporaryDirectory();
          file = await File("${temp.path}/${u['phone']}.png").create();
          file.writeAsBytesSync(u['avatar'] as Uint8List);
        }
        users.add(User(
            name: u['name'].toString(),
            phone: u['phone'].toString(),
            avatar: file));
      }
      return users;
    } catch (err) {
      print("error :- ${err}");
    }
  }

  Future InsertChart(Chat chat) async {
    try {
      final path = await DBname();
      Database db = await openDatabase(path);
      print("chat :- ${chat.toString()}");
      await db.insert('chats', chat.toMap());
    } catch (e) {
      print("Error :- ${e}");
    }
  }

  Future fetchChats(User user) async {
    try {
      List<Chat> chats = [];
      bool iscreate = true;
      final path = await DBname();
      Database db = await openDatabase(path);
      final istable = await db.query("sqlite_master", columns: ['name']);
      istable.forEach((element) {
        if (element['name'] == 'chats') {
          iscreate = false;
        }
      });
      if (iscreate) {
        print("table is creating");
        await db.execute('''
              CREATE TABLE chats(
                uid text primary key,
                sender text not null,
                reciver text not null,
                message text not null,
                createAt text not null
              )''');
        return chats;
      }
      final res = await db.query("chats",
          where: 'rechiver=${user.phone} OR sender=${user.phone}');
      print(res);
      chats = res.cast<Chat>();
      return chats;
    } catch (e) {
      print("error :- ${e}");
    }
  }
}
