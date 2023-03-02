
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chat/kisG0jdsp3XfRnndCVTD/Massage')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // ignore: non_constant_identifier_names
          final Documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: Documents?.length,
            itemBuilder: (context, index) => Container(
              child: Text(
                Documents![index]['Text'],
                style: const TextStyle(fontSize: 28),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Chat/kisG0jdsp3XfRnndCVTD/Massage')
              .add({'Text': 'Kya bolti public!'});
        },
        child:const Icon(Icons.send),
      ),
    );
  }
}
