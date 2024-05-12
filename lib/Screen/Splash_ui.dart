import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:texthub/Screen/Auth_ui.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: sizes.height * 0.55,
            color: Colors.blueGrey,
            child: LottieBuilder.asset("assets/lottie/splashcreen.json"),
          ),
          SizedBox(
            height: sizes.height * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome to a \nTexthub,",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connect with Ease,",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  " Your Gateway to Seamless Conversations!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: sizes.height * 0.050,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: sizes.width * 0.065,
              vertical: sizes.height * 0.02
            ),
            padding: EdgeInsets.symmetric(horizontal: sizes.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(
                25,
              ),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            height: sizes.height * 0.08,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Get.to(() => Auth());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: sizes.width * 0.1,
                  ),
                  Text(
                    "Get Start",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: sizes.width * 0.05,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: sizes.height * 0.035,
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
