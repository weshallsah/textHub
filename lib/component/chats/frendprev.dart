import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class prev extends StatefulWidget {
  final username;
  final profIMG;
  final roomID;
  final FrndUid;
  bool isArchive;

  prev(
    this.username,
    this.profIMG,
    this.roomID,
    this.FrndUid,
    this.isArchive,
  );

  @override
  State<prev> createState() => _prevState();
}

class _prevState extends State<prev> {
  bool isarchiv = false;
  bool isdelet = false;
  @override
  Widget build(BuildContext context) {
    // isarchiv = false;
    // isdelet = false;
    return Container(
      margin: EdgeInsets.only(
        top: 19.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isarchiv)
            AnimatedContainer(
              duration: Duration(
                milliseconds: 350,
              ),
              width: 144.w,
              height: 77.h,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 147, 221, 158),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(21.r),
                  bottomRight: Radius.circular(21.r),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      // height: 27.h,
                      // width: 27.w,
                      margin: EdgeInsets.only(
                        left: 2.w,
                        // top: 21.h,
                      ),
                      child: Icon(
                        widget.isArchive
                            ? Icons.unarchive_outlined
                            : Icons.archive_outlined,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        // final docID=snapshot.

                        await FirebaseFirestore.instance
                            .collection('Chat')
                            .doc(widget.roomID)
                            .update({
                          'isArchive': !widget.isArchive,
                        });
                        // setState(() {
                        //   isarchiv = false;
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.all(0),
                        // margin: EdgeInsets.only(left: 4.2.w),

                        child: Text(
                          widget.isArchive ? "Unarchive" : "Archive",
                          style: TextStyle(
                            fontSize: widget.isArchive ? 17.sp : 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.poppins().toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isarchiv = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(0),
                        height: 27,
                        // width: 27.w,
                        margin: EdgeInsets.only(
                          left: 2,
                          // top: 23.h,
                        ),
                        child: Icon(
                          Icons.cancel_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            child: GestureDetector(
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
              onHorizontalDragUpdate: (details) {
                int sensitivity = 8;

                if (details.delta.dx > sensitivity) {
                  setState(
                    () {
                      if (isdelet) {
                        isdelet = false;
                      } else {
                        isarchiv = true;
                      }
                    },
                  );
                } else if (details.delta.dx < -sensitivity) {
                  setState(
                    () {
                      if (isarchiv) {
                        isarchiv = false;
                      } else {
                        isdelet = true;
                      }
                    },
                  );
                  // }
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 29,
                ),
                padding: EdgeInsets.all(0),
                // color: Colors.amber,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // color: Colors.amber,
                        height: isarchiv || isdelet ? 25 : 60,
                        child: Image(
                          image: NetworkImage(
                            widget.profIMG,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                              color: widget.isArchive
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Recent massage",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: widget.isArchive
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isdelet)
            AnimatedContainer(
              duration: Duration(
                milliseconds: 350,
              ),
              width: 144.w,
              height: 77.h,
              decoration: BoxDecoration(
                color: Color(0xFFFF4155),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21.r),
                  bottomLeft: Radius.circular(21.r),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isdelet = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(0),
                        height: 27,
                        // width: 27.w,
                        margin: EdgeInsets.only(
                          left: 2,
                          // top: 23.h,
                        ),
                        child: Icon(
                          Icons.cancel_outlined,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      // height: 27.h,
                      // width: 27.w,
                      margin: EdgeInsets.only(
                        left: 2.w,
                        // top: 21.h,
                      ),
                      child: Icon(Icons.delete_outline),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        // final docID=snapshot.

                        await FirebaseFirestore.instance
                            .collection('Chat')
                            .doc(widget.roomID)
                            .update({
                          'isArchive': !widget.isArchive,
                        });
                        // setState(() {
                        //   isarchiv = false;
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.all(0),
                        // margin: EdgeInsets.only(left: 4.2.w),

                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.poppins().toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
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
