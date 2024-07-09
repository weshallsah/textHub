import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 0.63);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height * 0.088,
            // color: Colors.grey,
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundImage: NetworkImage(
                          "https://b.fssta.com/uploads/application/soccer/headshots/713.png",
                        ),
                        // child: SvgPicture.asset(
                        //   fit: BoxFit.contain,
                        //   height: MediaQuery.of(context).size.height * 0.1,
                        //   'assets/svg/userAvatar.svg',
                        // ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Text(
                        "My Story",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey, width: 1.5),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            "Friends Story's",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.63,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.088,
                    // color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.035,
                        ),
                        CircleAvatar(
                          radius: 30,
                          // foregroundImage:
                          child: SvgPicture.asset(
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.1,
                            'assets/svg/userAvatar.svg',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text(
                          "WeshallSah",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
