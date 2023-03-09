import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Massage extends StatelessWidget {
  const Massage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Chat').snapshots(),
      builder: (context, chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docmassage = chatsnapshot.data?.docs;
        return ListView.builder(
          itemCount: docmassage?.length,
          itemBuilder: (context, index) => Text(
            docmassage?[index]['Text'],
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
