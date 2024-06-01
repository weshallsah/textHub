import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class Adduser extends StatelessWidget {
  final content;
  final avatar;
  final phone;
  const Adduser({super.key, this.content, this.avatar, this.phone});

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
                itemCount: content.length,
                itemBuilder: (context, index) {
                  print(content[index].phones);
                  return UserCard(
                    user: content[index],
                    avatar: avatar[content[index].id],
                    phone: phone[content[index].id],
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
  final avatar;
  final phone;
  const UserCard({super.key, this.user, this.avatar, this.phone});

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
            foregroundImage: avatar != null ? FileImage(avatar) : null,
            child: avatar == null
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
                user.displayName,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${phone}",
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
