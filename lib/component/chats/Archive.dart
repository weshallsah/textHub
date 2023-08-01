import 'package:chatbot/component/chats/frendprev.dart';
import 'package:chatbot/component/listFrnd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Archive extends StatefulWidget {
  final Myuid, Docs;
  const Archive({super.key, this.Myuid, this.Docs});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  //  geObjectt myuid => null;
  // String? myuid = '';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              print("rigth swipe");
              Navigator.pop(context);
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(
                        top: 40.h,
                        left: 34.w,
                      ),
                      child: Text(
                        "Text",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 4.w,
                        top: 40.h,
                      ),
                      height: 30.h,
                      width: 43.w,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r)),
                      alignment: Alignment.center,
                      child: Text(
                        "Hub",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 27.w,
                      height: 27.h,
                      // color: Colors.amber,
                      margin: EdgeInsets.only(
                        left: 39.w,
                        top: 43.h,
                      ),
                      // alignment: Alignment.,
                      child: const FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        child: Icon(
                          Icons.archive_outlined,
                        ),
                      ),
                    ),
                    Container(
                      width: 146.w,
                      height: 48.h,
                      margin: EdgeInsets.only(
                        left: 14.w,
                        top: 46.h,
                      ),
                      child: Text(
                        "Archive",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                        ),
                      ),
                    )
                  ],
                ),
                ListFrnd(docs: widget.Docs,myuid: widget.Myuid,isarchiv: true,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
