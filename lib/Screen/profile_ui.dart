import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:texthub/Controller/Profile.controller.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final Profilecontroller profilecontroller = Get.put(Profilecontroller());

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.13,
          // color: Colors.amber,
          child: GetBuilder<Profilecontroller>(builder: (controller) {
            return CircleAvatar(
              radius: MediaQuery.of(context).size.height <= 700
                  ? (MediaQuery.of(context).size.height * 0.13) / 2
                  : (MediaQuery.of(context).size.height * 0.165) / 2,
              foregroundImage: controller.avatar != null
                  ? FileImage(controller.avatar as File)
                  : null,
              child: controller.avatar == null
                  ? SvgPicture.asset(
                      'assets/svg/userAvatar.svg',
                      height: MediaQuery.of(context).size.height <= 700
                          ? (MediaQuery.of(context).size.height * 0.13)
                          : (MediaQuery.of(context).size.height * 0.163),
                    )
                  : null,
            );
          }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        GetBuilder<Profilecontroller>(builder: (controller) {
          return Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.04,
            child: Text(
              controller.name.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.055,
              vertical: MediaQuery.of(context).size.height * 0.016,
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                List icons = [
                  Icons.edit_document,
                  Icons.edit_notifications_outlined,
                  Icons.block_outlined,
                  Icons.backup_outlined,
                  Icons.help_outline_sharp,
                  Icons.logout_outlined
                ];
                List itemname = [
                  "Profile Edit",
                  "Notification",
                  "Block List",
                  "Chats Backup",
                  "Help&Feadback",
                  "Logout"
                ];
                return InkWell(
                  enableFeedback: true,
                  // hoverColor: Colors.gr,
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    profilecontroller.logout();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.086,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      border: Border(
                        bottom: index == 5 ? BorderSide.none : BorderSide(),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: index == 0
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        topRight: index == 0
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        bottomLeft: index == 5
                            ? Radius.circular(20)
                            : Radius.circular(0),
                        bottomRight: index == 5
                            ? Radius.circular(20)
                            : Radius.circular(0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Icon(
                                icons[index],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                              Text(
                                itemname[index],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
