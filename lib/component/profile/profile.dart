import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profilePage extends StatefulWidget {
  // final void Function(String url, String username) sndurser;
  profilePage();

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userpic = TextEditingController();
//   final url =
  // 'https://i.pinimg.com/originals/17/66/56/1766569ede614813665828719d0872e6.jpg';
  var url;
  var Username;
  var Email;
  final _auth = FirebaseAuth.instance.currentUser;
  final database = FirebaseFirestore.instance.collection('user');
  @override
  void initState() {
    database.doc(_auth?.uid).get().then((value) {
      userName.text = value['Username'];
      userpic.text = value['profile_img_url'];
      userEmail.text = value['Email'];
    });
    url = userpic.text;
    Username = userName.text;
    Email = userEmail.text;
    super.initState();
    // widget.sndurser(url, Username);
  }

  void edit() {
    if (userEmail.text != Username || userName.text != Email) {
      database.doc(_auth?.uid).update(
        {
          'Username': userName.text,
          'Email': userEmail.text,
        },
      );
    }
  }

  void imagepck(var Sources) async {
    final Future<XFile?> pkgImg;
    if (Sources == "gallery") {
      pkgImg = ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      pkgImg = ImagePicker().pickImage(source: ImageSource.camera);
    }

    // final  ref = FirebaseStorage.instance.ref().child('Prof_Img').child(userpic.text);
    // await ref.writeToFile(pkgImg).whenComplete(()async{
    // final userurl=ref.getDownloadURL();
    // userpic.text=userurl as String;
    // });
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
                width: 150.0,
                height: 150.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userpic.text),
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
                      onPressed: () {},
                      child: const Text(
                        "Edit image",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20),
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
                        controller: userName,
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
                    // const SizedBox(height: 180),
                    Text(userpic.text),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        onPressed: () {},
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
