import 'package:chatbot/module/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class forgot extends StatefulWidget {
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  String _email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // theme,
        toolbarHeight: 71.h,
        title: Container(
          // decoration: Theme.of(context),
          margin: EdgeInsets.only(
            left: 34.w,
            top: 40.h,
          ),
          width: 313.w,
          height: 70.h,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(0),
                // margin: EdgeInsets.only(
                //   top: 40.h,
                //   left: 34.w,
                // ),
                child: Text(
                  "Text",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 4.w,
                  // top: 40.h,
                ),
                height: 30.h,
                width: 43.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: _dragup ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(4.r)),
                alignment: Alignment.center,
                child: Text(
                  "Hub",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(
                left: 39.w,
                top: 149.h,
              ),
              height: 42.h,
              width: 237.w,
              child: Text(
                "Forgot Password",
                textAlign: TextAlign.start,
                // softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(
                left: 39.w,
              ),
              height: 20.h,
              width: 248.w,
              child: Text(
                "Link will be sent to your email address",
                textAlign: TextAlign.start,
                // softWrap: true,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 140.h,
              ),
              width: 375.w,
              height: 442.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(41.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: 37.w,
                      top: 45.h,
                    ),
                    height: 24.h,
                    width: 45.w,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.poppins().toString(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 9.h,
                      left: 32.w,
                    ),
                    height: 31.h,
                    width: 292.w,
                    alignment: Alignment.center,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.poppins().toString(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            !value.contains("@") ||
                            !value.contains(".")) {
                          return "please enter valid email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(
                          () {
                            _email = value;
                          },
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final forgot = DatabaseAuth();
                      forgot.forget(_email);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 31.h,
                        left: 39.w,
                      ),
                      width: 300.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Send Link",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.poppins().toString(),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
