import 'package:flutter/material.dart';

import '../massage.dart';
import '../send.dart';

class chatRoom extends StatelessWidget {
  final RoomId;
  final userPic;
  final username;
  const chatRoom({this.RoomId, this.userPic, this.username});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: CircleAvatar(
        //   radius: 5,
        //   backgroundImage: userPic!=null?NetworkImage(userPic):null,
        // ),
        
        title: Text(username),
      ),
      body: Container(
        child: Column(
          children:  [
            Expanded(
              child: Massage(ChatRoom: RoomId),
            ),
            Snd(RoomId: RoomId),
          ],
        ),
      ),
    );
  }
}