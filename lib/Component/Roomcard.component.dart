import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texthub/Controller/Home.controller.dart';

class RoomCard extends StatelessWidget {
  Homecontroller controller;
  RoomCard(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 35,
            foregroundImage:
                controller.isavatar.value ? FileImage(controller.avatar) : null,
            child: !controller.isavatar.value
                ? SvgPicture.asset(
                    'assets/svg/userAvatar.svg',
                    // fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height <= 700
                        ? (MediaQuery.of(context).size.height * 0.13)
                        : (MediaQuery.of(context).size.height * 0.163),
                  )
                : null,
            // backgroundImage: NetworkImage(
            //     "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png"),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "WeshallSah",
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "this is my last message",
                style: TextStyle(
                  fontSize: 15,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
          ),
          Column(
            children: [
              Text(
                "4:30",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  "7",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
