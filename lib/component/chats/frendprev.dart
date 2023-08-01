import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(left: 34.w, top: 19.h),
      height: 60.h,
      width: 29.w,
      alignment: Alignment.center,
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.r,
              foregroundImage: NetworkImage(widget.profIMG),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16.w),
                      padding: EdgeInsets.all(0),
                      // color: Colors.amber,
                      // width: 235.w,
                      constraints: BoxConstraints(
                        maxWidth: 230.w,
                        minWidth: 0.w,
                      ),
                      height: 33.h,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.username,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.center,
                  height: 23.h,
                  child: Text(
                    "Recent massage",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.poppins().toString(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      ),
    );
  }
}



// onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => chatRoom(
//                     RoomId: widget.roomID,
//                     userID: widget.FrndUid,
//                     userPic: widget.profIMG,
//                     username: widget.username,
//                   ),
//                 ),
//               );
//             },

// Container(
//           padding: EdgeInsets.all(0),
//           height: 60,
//           color: Colors.blue,
//           width: 180,
//           margin: EdgeInsets.all(0),
//           child: GestureDetector(
//             child: Container(
//               // decoration: BoxDecoration(),
//               color: Colors.black,
//               padding: EdgeInsets.all(0),
//               margin: EdgeInsets.only(left: 34.w, top: 19.h),
              // height: 60.h,
              // width: 29.w,
//               // alignment: Alignment.center,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30.r,
//                     foregroundImage: NetworkImage(widget.profIMG),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 16.w),
//                         padding: EdgeInsets.all(0),
//                         color: Colors.amber,
//                         // width: 125.w,
//                         height: 33.h,
//                         alignment: Alignment.center,
//                         child: Text(
//                           widget.username,
//                           style: TextStyle(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: "Poppins",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 16.w),
//                         padding: EdgeInsets.all(0),
//                         color: Colors.blue,
//                         alignment: Alignment.center,
//                         // width: 125.w,
//                         height: 23.h,
//                         child: Text(
//                           "Recent massage",
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: "Poppins",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),