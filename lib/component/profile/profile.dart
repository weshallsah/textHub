import 'package:chatbot/component/Auth/auth.dart';
import 'package:chatbot/component/Auth/uploadAvtar.dart';
import 'package:chatbot/module/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  final Avtar, username;
  Profile(this.Avtar, this.username);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController URL = TextEditingController();
  bool iseditmode = false;
  bool editprofile = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasestore().fetchdata(firstname, lastname, email, username, about);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        elevation: 0,
      ),
      body: Container(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 8) {
              // print("rigth");
              Navigator.pop(context);
            }
            // else if(details.delta.dx<-8){
            //   print("left");
            // }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 96,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(widget.Avtar),
                        ),
                      ),
                    ),
                  ),
                  if (editprofile)
                    Container(
                      margin: EdgeInsets.only(
                        top: 62,
                        left: 62,
                      ),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue),
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            URL.text = widget.Avtar;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  chooseAvtar((bool value) {}, true, URL),
                            ),
                          );
                        },
                        style: ButtonStyle(),
                        icon: Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  about.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              if (!iseditmode)
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(31),
                        topRight: Radius.circular(31),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 36,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "Setting.",
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              iseditmode = true;
                              editprofile = true;
                            });
                          },
                          child: settingContainer("Edit Profile", false),
                        ),
                        settingContainer("Dark Mode", false),
                        GestureDetector(
                          child: settingContainer("Feedback", false),
                        ),
                        GestureDetector(
                          child: settingContainer("About us", true),
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: settingContainer("Logout", true),
                        ),
                        GestureDetector(
                          onTap: () {
                            databasestore().delete();
                            DatabaseAuth().delete();
                          },
                          child: settingContainer("Delete Account", true),
                        ),
                      ],
                    ),
                  ),
                ),
              if (iseditmode)
                Expanded(
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 34,
                      // vertical: 34,
                    ),
                    duration: Duration(
                      milliseconds: 350,
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Name(firstname, lastname),
                          teztcontainer('Email', email),
                          teztcontainer('username', username),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.amber,
                                margin: EdgeInsets.only(
                                  top: 20,
                                  // left: 32,
                                ),
                                child: Text(
                                  "about",
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
                                  controller: about,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {
                              databasestore().updata(
                                  firstname.text,
                                  lastname.text,
                                  username.text,
                                  email.text,
                                  about.text);
                              setState(() {
                                iseditmode = false;
                                editprofile = false;
                              });
                            },
                            child: Text(
                              "Save changes",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class settingContainer extends StatefulWidget {
  final Name;
  final istrue;
  settingContainer(this.Name, this.istrue);

  @override
  State<settingContainer> createState() => _settingContainerState();
}

class _settingContainerState extends State<settingContainer> {
  bool isdark = false;
  void isactive(bool value) {
    setState(() {
      isdark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: 16,
            ),
            child: Text(
              widget.Name,
              style: TextStyle(
                fontSize: 22.sp,
                color:
                    widget.Name == "Logout" || widget.Name == "Delete Account"
                        ? Colors.red
                        : Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        if (widget.Name == "Dark Mode")
          SizedBox(
            width: 140,
          ),
        if (widget.Name == "Dark Mode")
          Switch(
            value: isdark,
            onChanged: isactive,
          ),
      ],
    );
  }
}
