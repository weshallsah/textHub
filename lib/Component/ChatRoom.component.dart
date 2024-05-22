import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:texthub/Controller/chat.controller.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({super.key});
  final ChatController chatController = Get.put(ChatController());
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
              radius: (size.height * 0.06) / 2,
              foregroundImage: NetworkImage(
                "https://b.fssta.com/uploads/application/soccer/headshots/713.png",
              ),
            ),
          ],
        ),
        title: Text(
          "Username",
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
                          itemCount: controller.chat.value.length??0,
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
