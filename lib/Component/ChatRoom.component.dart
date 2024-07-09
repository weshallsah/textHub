import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:texthub/Controller/chat.controller.dart';
import 'package:texthub/DB/model/user.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoom extends StatelessWidget {
  User user;
  IO.Socket socket;
  File? avatar;
  late ChatController chatController;
  ChatRoom(this.user, this.socket, {super.key}) {
    chatController = Get.put(ChatController(socket, user));
    createavatar();
  }
  void createavatar() async {
    if (user.avatar != "") {
      final temp = await getTemporaryDirectory();
      avatar = await File("${temp.path}/${user.phone}.png").create();
      avatar?.writeAsBytesSync(user.avatar as Uint8List);
    }
  }

  // final
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.08,
        backgroundColor: Colors.blueGrey.shade400,
        leadingWidth: size.width * 0.27,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
            CircleAvatar(
              radius: (size.height * 0.055) / 2,
              foregroundImage: avatar != null ? FileImage(avatar!) : null,
              child: user.avatar == null
                  ? SvgPicture.asset(
                      'assets/svg/userAvatar.svg',
                      height: MediaQuery.of(context).size.height <= 700
                          ? (MediaQuery.of(context).size.height * 0.13)
                          : (MediaQuery.of(context).size.height * 0.163),
                    )
                  : null,
            ),
          ],
        ),
        title: Text(
          "${user.name}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GetBuilder<ChatController>(builder: (controller) {
            return IconButton(
              iconSize: size.height * 0.03,
              color: Colors.black,
              onPressed: () {
                controller.ismenu.value = !controller.ismenu.value;
              },
              icon: Icon(
                Icons.more_vert_rounded,
              ),
            );
          })
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.blueGrey,
                  height: size.height * 0.81,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                  ),
                  child: GetBuilder<ChatController>(
                    builder: (controller) {
                      return Obx(
                        () => ListView.builder(
                          itemCount: controller.chat.value.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: index % 2 == 0
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: Durations.medium1,
                                  constraints: BoxConstraints(
                                    maxWidth: size.width * 0.7,
                                    minWidth: 0,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.003,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: index % 2 == 0
                                          ? Radius.circular(0)
                                          : Radius.circular(15),
                                      bottomRight: index % 2 == 0
                                          ? Radius.circular(15)
                                          : Radius.circular(0),
                                    ),
                                  ),
                                  child: Text(
                                    controller.chat.value[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                              ],
                            );
                          },
                          reverse: true,
                        ),
                      );
                    },
                  ),
                ),
                GetBuilder<ChatController>(builder: (controller) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 181, 209, 255),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.06,
                        ),
                        Expanded(
                          child: Container(
                            // duration: Duration(milliseconds: 50),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              controller: controller.message,
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: Icon(Icons.mic),
                        ),
                        IconButton(
                          iconSize: 30,
                          onPressed: () {
                            controller.send();
                          },
                          icon: Icon(Icons.send_outlined),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          GetBuilder<ChatController>(builder: (controller) {
            return Obx(() {
              if (controller.ismenu.value) {
                return Positioned(
                  top: size.height * 0.003,
                  right: size.width * 0.005,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade300,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.5,
                  ),
                );
              }
              return Container();
            });
          }),
        ],
      ),
    );
  }
}
