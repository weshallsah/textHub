import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:texthub/Controller/Auth.controller.dart';

class CompeletProfile extends StatelessWidget {
  final size;
  CompeletProfile(this.size);
  final profilecontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      // color: Colors.amber,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            alignment: Alignment.center,
            child: Text(
              "Complete Your Profile",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GetBuilder<AuthController>(
            builder: (controller) {
              return Container(
                child: Stack(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        controller.imagepick();
                      },
                      child: Obx(
                        () => CircleAvatar(
                          radius: MediaQuery.of(context).size.height <= 700
                              ? (MediaQuery.of(context).size.height * 0.13) / 2
                              : (MediaQuery.of(context).size.height * 0.165) /
                                  2,
                          backgroundColor: Colors.grey,
                          foregroundImage: controller.isavatar.value
                              ? FileImage(controller.avatar)
                              : null,
                          child: !controller.isavatar.value
                              ? SvgPicture.asset(
                                  'assets/svg/userAvatar.svg',
                                  // fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height <= 700
                                          ? (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13)
                                          : (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.163),
                                )
                              : null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Icon(
                        Icons.add_a_photo,
                        size:
                            MediaQuery.of(context).size.height <= 700 ? 25 : 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.centerLeft,
            child: GetBuilder<AuthController>(
              builder: (controller) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: controller.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      // letterSpacing: 5,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.45,
          ),
          GetBuilder<AuthController>(
            builder: (controller) {
              return Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.065,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  height: size.height * 0.075,
                  alignment: Alignment.center,
                  width: size.width * 0.7,
                  child: controller.isclecked.value
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            if (!controller.isclecked.value) {
                              controller.completeprofile();
                            }
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "Get Start",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
