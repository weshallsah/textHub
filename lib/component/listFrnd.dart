import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final FrndList = snapshot.data?.docs;
          if (FrndList != null && FrndList.length > 0) {
            return Expanded(
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
                  return prev(
                    FrndList[index]['Username'],
                    FrndList[index]['ProfImg'],
                    FrndList[index]['ChatRoomId'],
                    uid,
                  );
                  // return Container(
                  //   margin: EdgeInsets.all(8),
                  //   height: 60.h,
                  //   width: 250.w,
                  //   color: Colors.blue,
                  // );
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
