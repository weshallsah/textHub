import 'package:chatbot/component/chats/Archive.dart';
import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/component/listFrnd.dart';
import 'package:chatbot/component/profile/profile.dart';
import 'package:chatbot/component/sreach.dart';
import 'package:chatbot/screen/searchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../component/chats/frendprev.dart';

class chatBox extends StatefulWidget {
  final drag_,docs,Myuid;
  chatBox({
    super.key,
    this.drag_, this.docs, this.Myuid,
  });

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.only(top: widget.drag_ ? 10.h : 39.h),
      width: 375.w,
      height:  700.h , 
      // constraints: BoxConstraints(maxHeight: 700.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: widget.drag_ ? Radius.circular(0) : Radius.circular(41.r),
          topRight: widget.drag_ ? Radius.circular(0) : Radius.circular(41.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBox(),
          ListFrnd(
            docs:widget.docs,
            myuid:widget.Myuid,
            isarchiv: false,
          ),
        ],
      ),
    );
  }
}
