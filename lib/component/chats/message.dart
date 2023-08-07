// ignore_for_file: non_constant_identifier_names
import 'package:chatbot/component/chats/massagepop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class message extends StatelessWidget {
  final ChatRoom;
  // ignore: use_key_in_widget_constructors
  const message({this.ChatRoom});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // ignore: await_only_futures
      future: Future(() async => await FirebaseAuth.instance),
      builder: (context, futursnapshot) {
        if (futursnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docuid = futursnapshot.data?.currentUser;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Chat')
              .doc(ChatRoom)
              .collection('Message')
              .orderBy('Createdat', descending: true)
              .snapshots(),
          builder: (context, chatsnapshot) {
            if (chatsnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docmassage = chatsnapshot.data?.docs;
            // final _User =FirebaseFirestore.instance.collection('user').doc(docuid?.uid).get();
            return ListView.builder(
              itemCount: docmassage?.length,
              itemBuilder: (context, index) {
                final isvanishday =
                    DateTime.now().day - docmassage?[index]['isvanishDay'];
                final isvanishTime =
                    DateTime.now().hour - docmassage?[index]['isvanishTime'];
                print("Time : ${isvanishTime}");
                print("Day : ${isvanishday}");
                print(DateTime.now().hour);
                if (isvanishday == 1 && isvanishTime >= 0) {
                  // print("Entered");
                  FirebaseFirestore.instance
                      .collection('Chat')
                      .doc(ChatRoom)
                      .collection('Massage')
                      .doc(docmassage?[index].id)
                      .delete();
                }
                if (isvanishday >= 2) {
                  FirebaseFirestore.instance
                      .collection('Chat')
                      .doc(ChatRoom)
                      .collection('Massage')
                      .doc(docmassage?[index].id)
                      .delete();
                }
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment:
                        docmassage?[index]['UserId'] == docuid?.uid
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      massagePop(
                        docmassage?[index]['Text'],
                        docmassage?[index]['UserId'] == docuid?.uid
                            ? true
                            : false,
                        docmassage?[index]['userProf'],
                      ),
                    ],
                  ),
                );
              },
              reverse: true,
            );
          },
        );
      },
    );
  }
}
