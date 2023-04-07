import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class profilePage extends StatefulWidget {
  final void Function(bool isEdit) _isedited;
  profilePage(this._isedited);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final url = '';
  File? ProfImage;
  TextEditingController Username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  String? userName = '';
  String? Useremail = '';
  String? profilimage = '';

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            userName = snapshot.data()!['Username'];
            Username.text = snapshot.data()!['Username'];
            Useremail = snapshot.data()!['Email'];
            userEmail.text = snapshot.data()!['Email'];
            profilimage = snapshot.data()!['profile_img_url'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void imagepck(String? _Source) async {
    var newUrl="";
    if (_Source == "gallery") {
      final pickedimgfile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 20);
      setState(() {
        ProfImage = File(pickedimgfile!.path);
      });
    } else {
      final pickedimgfile =
          await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 20);
      setState(() {
        ProfImage = File(pickedimgfile!.path);
      });
    }
    try {
      // final ref;
      if (profilimage != "") {
        final ref = FirebaseStorage.instance.refFromURL(profilimage!);
        UploadTask uploadTask = ref.putFile(ProfImage!);
        await uploadTask.whenComplete(() async {
          newUrl = await ref.getDownloadURL();
          print("complete");
        });
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child('Prof_Img')
            .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');
        UploadTask uploadTask = ref.putFile(ProfImage!);
        await uploadTask.whenComplete(() async {
          newUrl = await ref.getDownloadURL();
          print("complete");
        });
      }

      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'profile_img_url': newUrl});
    } on PlatformException catch (err) {
      String? massage = "something went wrong";
      if (err.message != null) {
        massage = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(massage as String),
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  void editProfile() async {
    if (Useremail != userEmail.text || userName != Username.text) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'Username': Username.text,
        'Email': userEmail.text,
      }).whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile was update"),
          ),
        );
      });
      widget._isedited(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 18, top: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
              Container(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blueGrey,
                  child: CircleAvatar(
                    radius: 78,
                    foregroundImage: ProfImage!=null?FileImage(ProfImage!):null,
                    backgroundImage: profilimage != null
                        ? NetworkImage(profilimage!)
                        : NetworkImage(url),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                // color: Colors.amber,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 28,
                    ),
                    TextButton(
                      onPressed: () {
                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 700),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 12,
                                  right: 12,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(197, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 80,
                                      width: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          imagepck("gallery");
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.filter,
                                              size: 50,
                                            ),
                                            Text(
                                              "gallery",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 80,
                                      width: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          imagepck("Camera");
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.camera,
                                              size: 50,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Edit image",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: Username,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "username",
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
                        // onSaved: (newValue) {
                        //   _Email = newValue as String;
                        // },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: userEmail,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Email",
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
                        // onSaved: (newValue) {
                        //   _Email = newValue as String;
                        // },
                      ),
                    ),
                    const SizedBox(height: 200),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        onPressed: () {
                          editProfile();
                        },
                        child: const Text(
                          "save",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
