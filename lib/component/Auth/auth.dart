// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors

import 'dart:io';

import 'package:chatbot/component/profile/imagepicker.dart';
import 'package:flutter/material.dart';

class Authfrom extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isloading;

  final void Function(String email, String password, String username,
      // ignore: non_constant_identifier_names
      bool islogin, File? ProfImg) submitfm;

  const Authfrom(this.submitfm, this.isloading);
  @override
  State<Authfrom> createState() => _AuthfromState();
}

class _AuthfromState extends State<Authfrom> {
  final _formkey = GlobalKey<FormState>();
  var _islogin = true;
  var _password="";
  // ignore: non_constant_identifier_names
  var _Username="";
  // ignore: non_constant_identifier_names
  var _Email="";
  // prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables
  var _ProfImg;

  void _getImg(File image){
    _ProfImg=image;
  }

  void _trysumbmit() {
    final isvalid = _formkey.currentState?.validate();
    if (isvalid != null) {
      _formkey.currentState?.save();
    }
    widget.submitfm(
      _Email,
      _password,
      _Username,
      _islogin,
      _ProfImg,
    );
  }
  // void printdata(){
  //   final isvalid = _formkey.currentState?.validate();
  //   if (isvalid != null) {
  //     _formkey.currentState?.save();
  //   } 
  //   print(_Email);
  //   print(_Username);
  //   print(_password);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.blue,
                width: 350,
                height: 70,
                child: Text(
                  _islogin ? "Login" : "Signup",
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: _islogin ? 100 : 25,
              ),
              if (!_islogin) PickImg(_getImg),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(8),
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.only(
                        //   bottom: 10,
                        // ),
                        border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                      ),
                      cursorHeight: 30,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      validator: (value) {
                        if (value == null ||
                            !value.contains("@") ||
                            !value.contains(".")) {
                          return "please enter valid email";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _Email = newValue as String;
                      },
                    ),
                  ),
                ],
              ),
              if (!_islogin)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "username",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.all(8),
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.only(
                          //   bottom: 10,
                          // ),
                          border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                        cursorHeight: 30,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        validator: (value) {
                          if (value == null || value.length < 7) {
                            return "please enter valid username";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _Username = newValue as String;
                        },
                      ),
                    ),
                  ],
                ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(8),
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.only(
                        //   bottom: 10,
                        // ),
                        border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                      ),
                      cursorHeight: 30,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      validator: (value) {
                        if (value == null || value.length < 7) {
                          return "please check password";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _password = newValue as String;
                      },
                    ),
                  ),
                ],
              ),
              if (!_islogin)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Re-Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.all(8),
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.only(
                          //   bottom: 10,
                          // ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                        cursorHeight: 30,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "please enter valid username";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: _islogin ? 320 : 20,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                  onPressed: _trysumbmit,
                  child: Text(
                    _islogin ? "Login" : "Signup",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _islogin ? "I don't have account : " : "I have account : ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: Text(
                      _islogin ? "signup" : "Login",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
