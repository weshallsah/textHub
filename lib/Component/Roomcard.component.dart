import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texthub/Controller/Home.controller.dart';
import 'package:texthub/DB/model/user.model.dart';

class RoomCard extends StatelessWidget {
  Homecontroller controller;
  User user;
  RoomCard(this.controller, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    // print(user);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                foregroundImage:
                    user.avatar != null ? FileImage(user.avatar) : null,
                child: user.avatar == null
                    ? SvgPicture.asset(
                        'assets/svg/userAvatar.svg',
                        height: MediaQuery.of(context).size.height <= 700
                            ? (MediaQuery.of(context).size.height * 0.13)
                            : (MediaQuery.of(context).size.height * 0.163),
                      )
                    : null,
                // backgroundImage: NetworkImage(
                //     "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${user.name}",
                    style: TextStyle(
                      fontSize: 18,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${user.phone}",
                    style: TextStyle(
                      fontSize: 15,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "4:30",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                // padding: EdgeInsets.symmetric(
                //   horizontal: 10,
                //   vertical: 5,
                // ),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  "7",
                  style: TextStyle(
                    fontSize: 14,
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
