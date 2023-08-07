import 'package:chatbot/component/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class greetme extends StatefulWidget {
  final Avtar, username;
  greetme(this.Avtar, this.username);

  @override
  State<greetme> createState() => _greetmeState();
}

class _greetmeState extends State<greetme> {
  String Greet = "";
  final url =
      'https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2FGroupprofile.png?alt=media&token=cda8d654-2c10-43c3-afd0-a682e0c48de9';
  // String _username = "vishalsah";
  // String _fontfamily = "Poppins";

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
    return Flexible(
      // flex: 1,

      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 350,
        ),
        // color: Colors.amber,
        padding: EdgeInsets.symmetric(
          horizontal: 27,
          vertical: 30,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Greet,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.username + " !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            widget.Avtar,
                            widget.username,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(),
            // ),
            Expanded(
              flex: 1,
              child: Container(
                height: 80,
                // width: 80,
                // color: Colors.blue,
                child: CircleAvatar(
                  // radius: 55,
                  foregroundImage: NetworkImage(widget.Avtar),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
