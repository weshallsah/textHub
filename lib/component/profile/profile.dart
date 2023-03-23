import 'package:chatbot/screen/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class profilPage extends StatefulWidget {
  const profilPage();

  @override
  State<profilPage> createState() => _profilPageState();
}

String? profilepic;

class _profilPageState extends State<profilPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController profurl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var username;
  var useremail;

  void initState() {
    super.initState();
    final _auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('user')
        .doc(_auth?.uid)
        .get()
        .then((value) {
      userEmail.text = value['Email'];
      userName.text = value['Username'];
      profurl.text=value['ImgUrl'];
    });
    username = userName.text;
    useremail = userEmail.text;
  }

  void editfm(String userName, String userEmail) async {
    final _auth = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('user').doc(_auth?.uid).update({
      'Username': userName,
      'Email': userEmail,
    });
    if (useremail != userEmail) {
      _auth?.updateEmail(userEmail);
    }
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "profile was update",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 70,
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.only(left: 16),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 180,
              child: const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.blueGrey,
                // child: Image(
                //   image: NetworkImage(
                //     'https://drive.google.com/file/d/1mPAkuooe8x8b-71mGGejs8BgHJZqhRt5/view?usp=share_link',
                //   ),
                // ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 350,
                      child: TextFormField(
                        controller: userName,
                        validator: (value) {
                          if (value == null || value.length < 7) {
                            return "please enter username";
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          // labelStyle: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 60,
                      width: 350,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: userEmail,
                        validator: (value) {
                          if (value == null ||
                              !value.contains("@") ||
                              !value.contains(".")) {
                            return "please enter valid email";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          // helperText: "One_direction_vishal",
                          // hintText: "vishalk74064@gmail.com",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        // onSaved: (newValue) => useremail=newValue,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          final isvalid = _formkey.currentState?.validate();
                          if (isvalid != null) {
                            _formkey.currentState?.save();
                          }
                          editfm(userName.text, userEmail.text);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
