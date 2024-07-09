import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:texthub/Component/ChatRoom.component.dart';
import 'package:texthub/Component/Roomcard.component.dart';
import 'package:texthub/Component/Search.component.dart';
import 'package:texthub/Controller/Home.controller.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home extends StatelessWidget {
  late IO.Socket socket;
  late Database db;
  Home(this.socket, this.db, {super.key}) {
    final homecontroller = Get.put(Homecontroller(socket));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Search(),
          Expanded(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.72,
              child: GetBuilder<Homecontroller>(
                
                builder: (controller) {
                  return Obx(
                    () => ListView.builder(
                      itemCount: controller.chatRooms.length,
                      itemBuilder: (context, index) {
                        // print(controller.chatRooms[index]);
                        return InkWell(
                          onTap: () {
                            Get.to(() => ChatRoom(controller.chatRooms[index],
                                controller.socket));
                          },
                          child:
                              RoomCard(controller, controller.chatRooms[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
