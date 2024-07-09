import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:texthub/Controller/nav.controller.dart';
import 'package:texthub/DB/controller/DB.controller.dart';
import 'package:texthub/Screen/Home_ui.dart';

class Nav extends StatelessWidget {
  Nav({super.key});
  final NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "TextHub",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GetBuilder<NavController>(
            builder: (controller) {
              switch (controller.current.value) {
                case "Chat":
                  return GetBuilder<NavController>(builder: (controller) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // DBcontroller().InsertUser();
                            DBcontroller().fetchusers();
                          },
                          icon: Icon(Icons.archive_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.userlist(navController);
                          },
                          icon: Icon(Icons.person_add_alt),
                        ),
                      ],
                    );
                  });
                default:
                  return IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_add_alt,
                    ),
                  );
              }
            },
          ),
        ],
      ),
      body: GetBuilder<NavController>(
        builder: (controller) {
          return Obx(() {
            // print(controller.issocket.value);
            if (controller.issocket.value) {
              return Home(controller.socket,controller.db);
            }
            return Center(
              child: LottieBuilder.asset("assets/lottie/Loading.json"),
            );
          });
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: const Color.fromARGB(255, 228, 241, 247),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavButton("Chat", Icons.message_outlined),
            NavButton("Story", Icons.donut_large_rounded),
            NavButton("Calls", Icons.call_outlined),
            NavButton("Profile", Icons.account_circle_outlined),
          ],
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final text;
  IconData icon;
  NavButton(this.text, this.icon, {super.key});

  final NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        switch (text) {
          case "Chat":
            print("Home");
            navController.idx.value = 0;
            navController.current.value = text;
            navController.refresh();
            break;
          case "Story":
            print("Story");
            navController.idx.value = 1;
            navController.current.value = text;
            navController.refresh();
            break;
          case "Calls":
            print("Calls");
            navController.idx.value = 2;
            navController.current.value = text;
            navController.refresh();
            break;
          default:
            print("Profile");
            navController.idx.value = 3;
            navController.current.value = text;
            navController.refresh();
            break;
        }
      },
      child: GetBuilder<NavController>(builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.063,
          width: MediaQuery.of(context).size.width * 0.225,
          child: Column(
            children: [
              Icon(
                icon,
                color:
                    controller.current.value == text ? Colors.blueAccent : null,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: controller.current == text ? Colors.blueAccent : null,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
