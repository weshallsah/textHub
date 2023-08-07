import 'package:chatbot/component/Auth/Forgot.dart';
import 'package:chatbot/module/database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Auth extends StatefulWidget {
  final Function(bool istrue) iscompleter;
  Auth(this.iscompleter);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  bool islogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Text",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  left: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Hub",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        // titleSpacing: double.infinity,

        actions: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  islogin = !islogin;
                });
              },
              child: Container(
                // height: 27,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(
                  right: 21,
                  bottom: 11,
                  top: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  islogin ? "Sign Up" : "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        automaticallyImplyLeading: false,
        // flexibleSpace: ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            margin: EdgeInsets.only(
              top: islogin ? 88 : 44,
              left: islogin ? 112 : 32,
            ),
            duration: Duration(milliseconds: 350),
            child: Text(
              islogin ? "Login" : "Register",
              style: TextStyle(color: Colors.white, fontSize: 28.sp),
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(
              // top: 44,
              left: islogin ? 112 : 32,
            ),
            duration: Duration(milliseconds: 350),
            child: Text(
              islogin ? "Login to see your chats" : "Create a new account",
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              margin: EdgeInsets.only(
                top: islogin ? 112 : 44,
                left: 0,
                right: 0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 34,
                // vertical: 34,
              ),
              duration: Duration(
                milliseconds: 350,
              ),
              alignment: Alignment.center,
              // height: 520,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(41.r),
                  topRight: Radius.circular(41.r),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!islogin) Name(firstname, lastname),
                    teztcontainer('Email', email),
                    if (!islogin) teztcontainer('username', username),
                    teztcontainer('password', password),
                    if (islogin)
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => forgot(),
                                  ),
                                );
                              },
                              child: Text(
                                "Click Here",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        if (!islogin) {
                          setState(() {
                            widget.iscompleter(false);
                          });
                        }
                        final _auth = DatabaseAuth();
                        _auth.FireAuth(firstname.text, lastname.text,
                            email.text, password.text, username.text, islogin);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 38,
                          top: 27,
                          right: 45,
                        ),
                        padding: EdgeInsets.only(
                          top: 11,
                          bottom: 11,
                        ),
                        // color: Colors.amberAccent,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.black),
                        alignment: Alignment.center,
                        child: Text(
                          islogin ? "Login" : "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Name extends StatefulWidget {
  TextEditingController FirstName;
  TextEditingController LastName;
  Name(this.FirstName, this.LastName);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 55.h,
        // ),
        Row(
          children: [
            // SizedBox(
            //   width: 32.w,
            // ),
            Text(
              "First Name",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 77.w,
            ),
            Text(
              "Last Name",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ],
        ),
        // SizedBox(
        //   height: 9.h,
        // ),
        Row(
          children: [
            Flexible(
              child: Container(
                // width: 130,

                child: TextField(
                  decoration: InputDecoration(),
                  controller: widget.FirstName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              child: Container(
                child: TextField(
                  controller: widget.LastName,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class teztcontainer extends StatefulWidget {
  String Text;
  TextEditingController input;
  teztcontainer(this.Text, this.input);

  @override
  State<teztcontainer> createState() => _teztcontainerState();
}

class _teztcontainerState extends State<teztcontainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.amber,
          margin: EdgeInsets.only(
            top: 20,
            // left: 32,
          ),
          child: Text(
            widget.Text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 9,
            // left: 32,
          ),
          child: TextFormField(
            controller: widget.input,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (value) {
              if (value != null &&
                  EmailValidator.validate(value) &&
                  widget.Text == 'Email') {
                return "please enter valid Mail ID";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
