import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texthub/Controller/Auth.controller.dart';

class VerifyOTP extends StatelessWidget {
  final size;
  VerifyOTP(this.size);
  final getotpcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        // color: Colors.amber,
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
                "Enter Your One Time Passcode",
                style: TextStyle(
                  fontSize: 25,
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
                "please enter OTP for verification to using textHub communication channel",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              // alignment: Alignment.center,
              // margin: EdgeInsets.symmetric(
              //   horizontal: 20,
              // ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OTP sended on ${getotpcontroller.phone.text}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GetBuilder<AuthController>(builder: (controller) {
                    return TextButton(
                      onPressed: () {
                        controller.check();
                      },
                      child: Text(
                        "Not me?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ],
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
                "OTP number",
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
                horizontal: 20,
              ),

              alignment: Alignment.centerLeft,
              child: GetBuilder<AuthController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: size.width * 0.14,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 5,
                          ),
                          onChanged: (value) {
                            print("value :- ${value}");
                            if (value != "") {
                              if (index != 5) {
                                controller.otps.add(value);
                                FocusScope.of(context).nextFocus();
                              }
                            } else {
                              if (index != 0) {
                                controller.otps.removeLast();
                                FocusScope.of(context).previousFocus();
                              }
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.4,
            ),
            GetBuilder<AuthController>(
              builder: (controller) {
                return Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.065,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
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
                                controller.verify();
                              }
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "verify",
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
      ),
    );
  }
}
