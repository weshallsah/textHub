// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors

import 'dart:io';

import 'package:auth_handler/auth_handler.dart';
import 'package:chatbot/component/Auth/Forgot.dart';
import 'package:chatbot/component/profile/imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Authfrom extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isloading;
  bool islogin;

  final void Function(
    String Firstname,
    String Lastname,
    String email,
    String password,
    String username,
  ) submitfm;

  Authfrom(this.submitfm, this.isloading, this.islogin);
  @override
  State<Authfrom> createState() => _AuthfromState();
}

class _AuthfromState extends State<Authfrom> {
  final _formkey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  TextEditingController Email = TextEditingController();
  TextEditingController username = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Otp = TextEditingController();
  var _issnd = false;
  var Firstname = "";
  var Lastname = "";
  var _password = "";
  var _confirmpassword = "";
  // ignore: non_constant_identifier_names
  var _Username = "";
  // ignore: non_constant_identifier_names
  var _Email = "";
  // prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var _ProfImg;
  var res = false;

  AuthHandler authHandler = AuthHandler();

  void verifyOTP() async {
    res = await authHandler.verifyOtp(Otp.text);
    // ignore: avoid_print
    print(' iscorrect : $res');
  }

  @override
  void _trysumbmit() {
    final isvalid = _formkey.currentState?.validate();
    if (_confirmpassword != _password) {
      SnackBar(
        content: Text(
          "password does not match",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.sp,
            fontFamily: GoogleFonts.poppins().toString(),
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
    if (isvalid != null && (res || widget.islogin)) {
      _formkey.currentState?.save();
    }
    print(username);
    print(_password);
    print(Email);

    widget.submitfm(
      Firstname,
      Lastname,
      _Email,
      _password,
      _Username,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              // Note: Sensitivity is integer used when you don't want to mess up vertical drag
              int sensitivity = 8;

              if (details.delta.dx > sensitivity) {
                // Right Swipe
                setState(() {
                  widget.islogin = false;
                });
                // print("rigth swipe");
                // Navigator.pop(context);
              } else if (details.delta.dx < -sensitivity) {
                // Up Swipe
                setState(() {
                  // _color = Colors.white;
                  widget.islogin = true;
                });
                // print("draged UP");
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(
                    left: widget.islogin ? 112 : 32.w,
                    top: widget.islogin ? 88.h : 44.h,
                  ),
                  height: 42.h,
                  width: 117.w,
                  child: Text(
                    widget.islogin ? "Login" : "Register",
                    textAlign: TextAlign.start,
                    // softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(
                    left: widget.islogin ? 112.w : 32.w,
                  ),
                  height: 20.h,
                  width: widget.islogin ? 151.w : 146.w,
                  child: Text(
                    widget.islogin
                        ? "Login to see your chats"
                        : "Create a new account",
                    textAlign: TextAlign.start,
                    // softWrap: true,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(
                    top: widget.islogin ? 122.h : 40.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(41),
                      topRight: Radius.circular(41),
                    ),
                  ),
                  height: widget.islogin ? 479.h : 557.h,
                  width: 375.w,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.islogin)
                          SizedBox(
                            height: 25.h,
                          ),
                        if (!widget.islogin)
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 350),
                                height: 26.h,
                                width: 87.w,
                                // color: Colors.amber,
                                // alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 55.h, left: 32.w),
                                child: Text(
                                  "First Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontFamily:
                                        GoogleFonts.poppins().toString(),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 350),
                                // color: Colors.amber,
                                // alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 55.h, left: 79.w),
                                child: Text(
                                  "Last Name",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().toString(),
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (!widget.islogin)
                          Row(
                            children: [
                              AnimatedContainer(
                                // color: Colors.amber,
                                duration: Duration(milliseconds: 350),
                                alignment: Alignment.centerLeft,
                                height: 24.h,
                                width: 130.w,
                                margin: EdgeInsets.only(top: 10.h, left: 32.w),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        GoogleFonts.poppins().toString(),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          GoogleFonts.poppins().toString(),
                                    ),
                                    // hintText: "Vishal",
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 350),
                                height: 24.h,
                                width: 130.w,
                                // color: Colors.amber,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 10.h, left: 32.w),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        GoogleFonts.poppins().toString(),
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          GoogleFonts.poppins().toString(),
                                    ),
                                    // hintText: "Sah",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        TextBox((vale) {
                          _Email = vale;
                        }, "Email", 45, false, true, false),
                        if (!widget.islogin)
                          TextBox((vale) {
                            _Username = vale;
                          }, "Username", 84, false, false, true),
                        TextBox((vale) {
                          _password = vale;
                        }, "Password", 84, widget.islogin ? false : true, false,
                            true),
                        if (!widget.islogin)
                          TextBox((vale) {
                            _confirmpassword = vale;
                          }, "confirm Password", 148, false, false, true),
                        if (widget.islogin)
                          AnimatedContainer(
                            duration: Duration(milliseconds: 350),
                            margin: EdgeInsets.only(
                              top: 7.h,
                              left: 36.w,
                            ),
                            padding: EdgeInsets.all(0),
                            height: 21.h,
                            width: 202.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 350),
                                  padding: EdgeInsets.all(0),
                                  height: 21.h,
                                  width: 125.w,
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily:
                                          GoogleFonts.poppins().toString(),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => forgot(),
                                      ),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 350),
                                    decoration: const BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          color: Color(0xA6A6A6),
                                          style: BorderStyle.solid,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(0),
                                    height: 21.h,
                                    width: 77.w,
                                    child: Text(
                                      "Click Here",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily:
                                            GoogleFonts.poppins().toString(),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            _trysumbmit();
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 350),
                            margin: EdgeInsets.only(
                              top: 27.h,
                              left: 38.w,
                            ),
                            width: 292.w,
                            height: 45.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              color: Colors.black,
                            ),
                            child: Text(
                              widget.islogin ? "Login" : "Sign Up",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().toString(),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatefulWidget {
  final void Function(String value) _Value;
  String Text;
  bool ispassword;
  bool isemail;
  bool isusername;
  double TextWidth;
  TextBox(this._Value, this.Text, this.TextWidth, this.ispassword, this.isemail,
      this.isusername);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late bool active;
  @override
  void initState() {
    // TODO: implement initState
    active = widget.ispassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 350),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 33.5.w,
            top: 20.h,
          ),
          height: 24.h,
          width: widget.TextWidth.w,
          child: Text(
            widget.Text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: GoogleFonts.poppins().toString(),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 350),
          margin: EdgeInsets.only(
            top: 9.h,
            left: 32.w,
          ),
          height: 31.h,
          width: 292.w,
          alignment: Alignment.center,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            decoration: widget.ispassword
                ? InputDecoration(
                    suffixIcon: active
                        ? IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              setState(() {
                                active = !active;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          )
                        : IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              setState(() {
                                active = !active;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye_outlined),
                          ),
                  )
                : InputDecoration(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: GoogleFonts.poppins().toString(),
            ),
            obscureText: active,
            validator: (value) {
              if (widget.isemail) {
                if (!EmailValidator.validate(value.toString())) {
                  return "Enter valid emailID";
                }
                return null;
              }
              if (widget.ispassword) {
                if (value == null) {
                  return "please enter password";
                }
                if (value != null && value.length <= 7) {
                  // value.
                  return "password must contain 7 characters";
                }
              }
              if (widget.isusername) {
                Future(
                  () async {
                    final isuniq = await FirebaseFirestore.instance
                        .collection('user')
                        .where('Username', isEqualTo: value.toString())
                        .get();
                    if (isuniq.size < 0) {
                      return "username is not available";
                    }
                  },
                );
                if (value == null) {
                  return "please Enter username";
                }
              }
              return null;
            },
            onSaved: (newValue) {
              widget._Value(newValue!);
            },
          ),
        ),
      ],
    );
  }
}
