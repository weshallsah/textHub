import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chooseAvtar extends StatefulWidget {
  final Function(bool istrue) ischeck;
  chooseAvtar(this.ischeck);

  @override
  State<chooseAvtar> createState() => _chooseAvtarState();
}

class _chooseAvtarState extends State<chooseAvtar> {
  String url =
      "https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2Fcommanprofileavtar.png?alt=media&token=b9791391-f85a-4e01-be99-ae7fd7f0dd7d";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 30,
              left: 22,
            ),
            child: Text(
              "complete profile",
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 22,
            ),
            child: Text(
              "Choose your perfect avatar",
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 22, top: 30),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.amber,
                    height: 62,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          url,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 23,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey,",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "VishalSah",
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "I am your Avatar!",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(),
                // ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
              top: 55,
            ),
            // color: Colors.amber,
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.ischeck(true);
                });
                // Navigator.pop(context);
              },
              child: Text(
                "next",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(41),
                  topRight: Radius.circular(41),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: 38,
                  left: 28,
                  right: 28,
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Avtar')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs != null &&
                          snapshot.data?.docs.length != null) {
                        final Avtar = snapshot.data?.docs[0]['avtar'];
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: Avtar.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  url = Avtar[index];
                                });
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .update(
                                  {
                                    'Avtar_URL': Avtar[index],
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(
                                  5,
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      Avtar[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    }
                    ;
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
