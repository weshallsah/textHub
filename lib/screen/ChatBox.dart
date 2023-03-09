import 'package:chatbot/component/chats/massage.dart';
import 'package:chatbot/component/chats/send.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            DropdownButton(
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
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
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
  }
}
