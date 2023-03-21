import 'dart:ffi';

import 'package:chatbot/component/chats/massage.dart';
import 'package:chatbot/component/chats/send.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatBox extends StatefulWidget {
  
  final void Function (bool _isprofile) clicked;
  chatBox(this.clicked);

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {

  void tryclicked(){
    widget.clicked(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            DropdownButton(
              // underline: ,
              dropdownColor: Theme.of(context).hoverColor,
              icon: const Icon(Icons.more_vert),
              onChanged: (itemidentifier) {
                if (itemidentifier == 'Logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              items: [
                DropdownMenuItem(
                  value: 'Logout',
                  child: Container(
                    // color: Color.fromARGB(230, 3, 168, 244),
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          // backgroundColor: const Color.fromRGBO(50, 75, 205, 1),
          child: ListView(children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: const [
                  SizedBox(height: 5),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      // backgroundImage: AssetImage('assets/img.jpg'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("one_direction_vishal",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("vishalk74064@gmail.com",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            const Divider(
                thickness: .06, color: Color.fromARGB(255, 30, 29, 29)),
            ListTile(
              iconColor: Colors.blueAccent,
              leading: const Icon(Icons.person),
              title: const Text('My Profile',
                  style: TextStyle(color: Colors.black)),
              onTap: tryclicked,
            ),
            ListTile(
              iconColor: Colors.blueAccent,
              leading: const Icon(Icons.settings),
              title:
                  const Text('Setting', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Add Navigation logic here
              },
            ),
            ListTile(
              iconColor: Colors.blueAccent,
              leading: const Icon(Icons.question_mark),
              title: const Text('About', style: TextStyle(color: Colors.black)),
              onTap: () {
                showAboutDialog(
                    context: context,
                    // applicationIcon: icon,
                    applicationName: "ChatBox",
                    applicationVersion: "0.0.2",
                    // useRootNavigator:
                    children: [
                      const Text("app is under devlopment"),
                    ]);
              },
            ),
          ]),
        ),
        body: Container(
          child: Column(
            children: const [
              Expanded(
                child: Massage(),
              ),
              Snd(),
            ],
          ),
        ));
    ;
  }
}
