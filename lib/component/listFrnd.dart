import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chats/frendprev.dart';

class ListFrnd extends StatefulWidget {
  final docs, myuid, isarchiv;
  const ListFrnd({
    super.key,
    this.docs,
    this.myuid,
    this.isarchiv,
  });

  @override
  State<ListFrnd> createState() => _ListFrndState();
}

class _ListFrndState extends State<ListFrnd> {
  String? roomId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .where(widget.docs.toString(), isEqualTo: true)
          .where("Ismess", isEqualTo: true)
          .where("isArchive", isEqualTo: widget.isarchiv)
          // .orderBy('Recent', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final FrndList = snapshot.data?.docs;
          if (FrndList != null && FrndList.length > 0) {
            return Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: FrndList.length,
                itemBuilder: (context, index) {
                  roomId = FrndList[index]['ChatRoomId'];
                  Map Frindid = FrndList[index]['FrndConver'];
                  String? uid;
                  Frindid.forEach(
                    (key, value) => {
                      if (key != widget.myuid) {uid = key}
                    },
                  );

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        prev(
                          FrndList[index]['Username'],
                          FrndList[index]['ProfImg'],
                          FrndList[index]['ChatRoomId'],
                          uid,
                          widget.isarchiv,
                          // isarchiv || isdelet ? true : false,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
