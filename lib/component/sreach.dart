import 'package:chatbot/screen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class searchBox extends StatefulWidget {
  const searchBox({super.key});

  @override
  State<searchBox> createState() => _searchBoxState();
}

class _searchBoxState extends State<searchBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 32.w,
            top: 30.h,
          ),
          child: Text(
            "Recent Chats",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          // color: Colors.amber,
          margin: EdgeInsets.only(
            left: 68.w,
            top: 30.h,
          ),
          // height: 25.65.h,
          // width: 26.w,

          child: IconButton(
            padding: const EdgeInsets.all(0),
            iconSize: 30.sp,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const searchPage(),
                  ),
                );
              });
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
