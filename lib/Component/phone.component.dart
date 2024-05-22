import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texthub/Controller/Auth.controller.dart';

class SendOTP extends StatelessWidget {
  final size;
  SendOTP(this.size);
  final getotpcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.15,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter Your Phone Number",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Text(
              "please enter phone numer to using textHub communication channel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              "Phone number",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: size.height * 0.07,
            // color: Colors.amber,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.07,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<AuthController>(builder: (controller) {
                  return Container(
                    width: size.width * 0.15,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      border: Border(
                        right: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                      ),
                    ),
                    child: TextField(
                      // controller.code.text,
                      controller: controller.code,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: size.width * 0.02,
                ),
                GetBuilder<AuthController>(builder: (controller) {
                  return Container(
                    height: double.infinity,
                    // color: Colors.amber,
                    width: size.width * 0.65,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller.phone,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 5,
                      ),
                    ),
                  );
                }),
              ],
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
                              controller.Getotp();
                            }
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            // color: Colors.amber,
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "continue",
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
