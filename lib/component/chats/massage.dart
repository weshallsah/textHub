import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Massage extends StatefulWidget {
  const Massage({super.key});

  @override
  State<Massage> createState() => _MassageState();
}

class _MassageState extends State<Massage> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
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
            reverse: true,
            itemCount: Documents?.length,
            itemBuilder: (context, index) => Container(
              child: Text(
                Documents![index]['Text'],
                style: const TextStyle(fontSize: 28),
              ),
            ),
          );
        },
      );
  }
}
