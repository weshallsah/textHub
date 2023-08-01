import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class greetme extends StatefulWidget {
  const greetme({super.key});

  @override
  State<greetme> createState() => _greetmeState();
}

class _greetmeState extends State<greetme> {
  String Greet = "";
  final url =
      'https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2FGroupprofile.png?alt=media&token=cda8d654-2c10-43c3-afd0-a682e0c48de9';
  String _username = "vishalsah";
  String _fontfamily = "Poppins";

  void greet() {
    final _time = DateTime.now().hour / 6;
    print(_time);
    if (_time >= 0.0 && _time < 1.0) {
      Greet = "Good Nigth";
    } else if (_time >= 1.0 && _time < 2) {
      Greet = "Good Morning";
    } else if (_time >= 2 && _time < 3) {
      Greet = "Good Afternoom";
    } else {
      Greet = "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    greet();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80.h,
          width: 175.w,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(
            left: 32.w,
            top: 28.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                width: 112.w,
                height: 23.h,
                alignment: Alignment.bottomLeft,
                child: Text(
                  Greet + ",",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                height: 37.h,
                width: 175.w,
                margin: EdgeInsets.all(0),
                // alignment: Alignment.topLeft,
                child: Text(
                  _username + "!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 28.sp,
                    fontFamily: _fontfamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  
                  padding: EdgeInsets.all(0),
                  height: 20.h,
                  width: 68.w,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(
                    0
                  ),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 13.sp,
                      fontFamily: _fontfamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80.h,
          width: 80.w,
          margin: EdgeInsets.only(left: 66.w, top: 30.h),
          child: CircleAvatar(
            foregroundImage: NetworkImage(url),
          ),
        )
      ],
    );
  }
}
