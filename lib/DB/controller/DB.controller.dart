import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:texthub/DB/constant/DBName.constant.dart';
import 'package:texthub/DB/model/chatroom.model.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:texthub/Srevice/Auth.Srevice.dart';

class DBcontroller {
  late Database db;
  void Createdb() async {
    try {
      final path = await DBname();
      await openDatabase(
        path,
        onCreate: (db, version) async {
          await db.execute('''
              CREATE TABLE users (
                uid text primary key autoincrement, 
                name text not null,
                phone text not null,
                email text
              )''');
          await db.execute('''
              CREATE TABLE chatrooms (
                phone text primary key,
                name text not null,
                avatar BLOB
              )''');
          await db.execute('''
              CREATE TABLE chats(
                uid text primary key,
                sender text not null,
                message text not null,
                createAt text not null,
              )''');
        },
      );
    } catch (e) {
      print("error :- ${e}");
    }
  }

  Future InsertChart(Chatroom chat) async {
    try {
      final path = await DBname();
      Database db = await openDatabase(path);
      User? user = await AuthSrevice().getuser();
      if (user == null) {
        throw "user not found";
      }
      final res = await db.query("${user.phone}-${chat.phone}");
      if (res.isEmpty) {
        await db.execute('''
                CREATE TABLE ${user.phone}-${chat.phone}(
                  uid integer primary key AUTOINCREMENT,
                  phone integer not null,
                  message text not null,
                  createAt DATETIME,
                )''');
      }
      db.insert("${user.phone}-${chat.phone}", chat.toMap());
    } catch (e) {
      print("Error :- ${e}");
    }
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE users ( 
        uid text primary key autoincrement, 
        name text not null,
        phone integer not null,
        email text)
        ''');
    });
  }

  // void insertuser() async {
  //   try {
  //     final user =
  //         await User(uid: "3", name: "name", phone: "9511286245", email: "email");
  //     print("user :- ${user.toString()}");
  //     // print(db);
  //     // final id = await db.insert("users", user.toMap());
  //     // print("id :- ${id}");
  //     final res = await db.query("users");
  //     print("res :- ${res}");
  //     db.delete("users");
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
