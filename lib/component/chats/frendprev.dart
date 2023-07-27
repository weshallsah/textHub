import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:flutter/material.dart';

class prev extends StatefulWidget {
  final username;
  final profIMG;
  final roomID;
  final FrndUid;
  prev(this.username, this.profIMG, this.roomID, this.FrndUid);

  @override
  State<prev> createState() => _prevState();
}

class _prevState extends State<prev> {
  @override
  Widget build(BuildContext context) {
    final Screensize = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        // decoration: BoxDecoration(),
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(
            left: Screensize.width * 0.09, top: Screensize.height * 0.023),
        height: Screensize.height * 0.07,
        width: Screensize.width * 0.78,
        alignment: Alignment.center,
        child: Row(
          children: [
            CircleAvatar(
              radius: (Screensize.height * 0.07) / 2,
              foregroundImage: NetworkImage(widget.profIMG),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: Screensize.width * 0.042),
                  padding: EdgeInsets.all(0),
                  // color: Colors.amber,
                  // width: 125,
                  height: Screensize.height * 0.04,
                  alignment: Alignment.center,
                  child: Text(
                    widget.username,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Screensize.width * 0.042),
                  padding: EdgeInsets.all(0),
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  // width: 125,
                  height: Screensize.height * 0.028,
                  child: const Text(
                    "Recent massage",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // behavior: HitTestBehavior.opaque,
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatRoom(
              RoomId: widget.roomID,
              userID: widget.FrndUid,
              userPic: widget.profIMG,
              username: widget.username,
            ),
          ),
        );
      },
    );
  }
}
