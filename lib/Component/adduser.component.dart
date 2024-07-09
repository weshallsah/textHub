import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:texthub/Controller/AddUser.controller.dart';
import 'package:texthub/Controller/nav.controller.dart';
import 'package:texthub/DB/controller/DB.controller.dart';

class Adduser extends StatelessWidget {
  final users;
  final NavController navController;
  Adduser({super.key, this.users, required this.navController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add User",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 500,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  // print(users[index].phones);
                  return InkWell(
                    onTap: () {
                      // DBcontroller().Createdb();
                      navController.adduser(users[index]);
                    },
                    child: UserCard(user: users[index]),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final user;
  const UserCard({super.key, this.user});

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
            radius: 30,
            foregroundImage: user.avatar != "" ? FileImage(user.avatar) : null,
            child: user.avatar == ""
                ? SvgPicture.asset(
                    'assets/svg/userAvatar.svg',
                    height: MediaQuery.of(context).size.height <= 700
                        ? (MediaQuery.of(context).size.height * 0.13)
                        : (MediaQuery.of(context).size.height * 0.163),
                  )
                : null,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                user.name,
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
    );
  }
}
