import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 0.012);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.075,
              vertical: MediaQuery.of(context).size.height * 0.005,
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey
                )
              )
            ),
            child: Text(
              "Call logs",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              // color: Colors.amber,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    margin: EdgeInsets.all(5),
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          // color: Colors.amber,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                foregroundImage: NetworkImage(
                                  "https://b.fssta.com/uploads/application/soccer/headshots/713.png",
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                "Weshallsah",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.035),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              size: 30,
                              color: index % 2 == 0 ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
