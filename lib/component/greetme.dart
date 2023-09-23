import 'package:chatbot/component/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class greetme extends StatefulWidget {
  final  username;
  TextEditingController Avtar;
  greetme(this.Avtar, this.username, {super.key});

  @override
  State<greetme> createState() => _greetmeState();
}

class _greetmeState extends State<greetme> {
  String Greet = "";
  // String _username = "vishalsah";
  // String _fontfamily = "Poppins";

  void greet() {
    final time = DateTime.now().hour / 6;
    print(time);
    if (time >= 0.0 && time < 1.0) {
      Greet = "Good Nigth";
    } else if (time >= 1.0 && time < 2) {
      Greet = "Good Morning";
    } else if (time >= 2 && time < 3) {
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
        duration: const Duration(
          milliseconds: 350,
        ),
        // color: Colors.amber,
        padding: const EdgeInsets.symmetric(
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
              child: SizedBox(
                height: 80,
                // width: 80,
                // color: Colors.blue,
                child: CircleAvatar(
                  // radius: 55,
                  foregroundImage: NetworkImage(widget.Avtar.text),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
