import 'package:chatbot/component/chats/massagepop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Massage extends StatelessWidget {
  const Massage({super.key});

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
        final docuid= futursnapshot.data?.currentUser;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Chat')
              .orderBy('Createdat', descending: true)
              .snapshots(),
          builder: (context, chatsnapshot) {
            if (chatsnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docmassage = chatsnapshot.data?.docs;
            return ListView.builder(
              itemCount: docmassage?.length,
              itemBuilder: (context, index) =>
                  massagePop(docmassage?[index]['Text'],
                  docmassage?[index]['Username'],
                  docmassage?[index]['UserId']==docuid?.uid?true:false,
                  ),
              reverse: true,
            );
          },
        );
      },
    );
  }
}
