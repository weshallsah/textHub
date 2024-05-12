import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texthub/Component/navbar.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
              height: size.height * 0.065,
              // color: Colors.amber,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
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
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            // color: Colors.amber,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  // color: Colors.amber,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Country Code",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.065,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05
                                    ),
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
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
                      child: Text(
                        "+91",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Container(
                    height: double.infinity,
                    // color: Colors.amber,
                    width: size.width * 0.7,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.45,
            ),
            Container(
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
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  Get.to(() => Nav());
                },
                child: Text(
                  "continue",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
