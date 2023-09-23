import 'package:chatbot/component/Auth/uploadAvtar.dart';
import 'package:chatbot/module/database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  final username;
  TextEditingController Avtar;
   Profile(this.Avtar, this.username, {super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController about = TextEditingController();
  bool iseditmode = false;
  bool editprofile = false;
  void istru(bool value, bool value2) {
    setState(() {
      iseditmode = value;
      editprofile = value2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasestore().fetchdata(
      firstname,
      lastname,
      email,
      username,
      about
    );
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
                margin: const EdgeInsets.only(
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
              Flexible(
                // flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 96,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.Avtar.text),
                          ),
                        ),
                      ),
                      if (editprofile)
                        Container(
                          margin: const EdgeInsets.only(top: 60, left: 65),
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            alignment: Alignment.topLeft,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      chooseAvtar((istrue) => null, true,widget.Avtar),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.amber,
                height: 25,
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  about.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              if (!editprofile) settingbutton(istru),
              if (editprofile)
                profileedit(about, email, firstname, lastname, username,istru),
            ],
          ),
        ),
      ),
    );
  }
}

class profileedit extends StatefulWidget {
  TextEditingController firstname, lastname, email, username, about;
  final Function(bool value, bool value2) istrue;
  profileedit(
      this.about, this.email, this.firstname, this.lastname, this.username,this.istrue, {super.key});

  @override
  State<profileedit> createState() => _profileeditState();
}

class _profileeditState extends State<profileedit> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        margin: const EdgeInsets.only(
          top: 34,
        ),
        padding: const EdgeInsets.only(
          top: 24,
          left: 34,
          right: 34,
        ),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  // flex: 1,
                  child: Text(
                    "Firstname",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  // flex: 1,
                  child: Text(
                    "Lastname",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    // width: 130,

                    child: TextField(
                      decoration: const InputDecoration(),
                      controller: widget.firstname,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Container(
                    child: TextField(
                      controller: widget.lastname,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // color: Colors.amber,
              margin: const EdgeInsets.only(
                top: 20,
                // left: 32,
              ),
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 9,
                // left: 32,
              ),
              child: TextFormField(
                controller: widget.email,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value != null && EmailValidator.validate(value)) {
                    return "please enter valid Mail ID";
                  }
                  return null;
                },
              ),
            ),
            Container(
              // color: Colors.amber,
              margin: const EdgeInsets.only(
                top: 20,
                // left: 32,
              ),
              child: Text(
                "username",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 9,
                // left: 32,
              ),
              child: TextFormField(
                controller: widget.username,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  // if (value != null &&
                  //     EmailValidator.validate(value) &&
                  //     widget.Text == 'Email') {
                  //   return "please enter valid Mail ID";
                  // }
                  return null;
                },
              ),
            ),
            Container(
              // color: Colors.amber,
              margin: const EdgeInsets.only(
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
              margin: const EdgeInsets.only(
                top: 9,
                // left: 32,
              ),
              child: TextFormField(
                controller: widget.about,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  // if (value != null &&
                  //     EmailValidator.validate(value) &&
                  //     widget.Text == 'Email') {
                  //   return "please enter valid Mail ID";
                  // }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  databasestore().updata(
                    widget.firstname.text,
                    widget.lastname.text,
                    widget.username.text,
                    widget.email.text,
                    widget.about.text,
                  );
                  widget.istrue(false,false);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.black,
                  ),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class settingbutton extends StatefulWidget {
  final Function(bool value, bool value2) istrue;
  const settingbutton(this.istrue, {super.key});

  @override
  State<settingbutton> createState() => _settingbuttonState();
}

class _settingbuttonState extends State<settingbutton> {
  bool isdark = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        margin: const EdgeInsets.only(
          top: 34,
        ),
        padding: const EdgeInsets.only(
          top: 24,
          left: 34,
        ),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Setting.",
            ),
            TextButton(
              onPressed: () {
                widget.istrue(true, true);
              },
              child: Text(
                "Edit profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Theme mode",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  Flexible(
                    child: Container(),
                  ),
                  Switch(
                    value: isdark,
                    onChanged: (value) {
                      setState(() {
                        isdark = !isdark;
                      });
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "about us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                DatabaseAuth().logout();
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                DatabaseAuth().delete();
              },
              child: Text(
                "Delete account",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
