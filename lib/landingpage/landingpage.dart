import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LandIng extends StatefulWidget {
  const LandIng({super.key});

  @override
  State<LandIng> createState() => _LandIngState();
}

class _LandIngState extends State<LandIng> {
  bool _isblue=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        // onEnd: ,
        color: Colors.blueGrey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_isblue)
              AnimatedContainer(
                duration: Duration(seconds: 2),
                color: Colors.amber,
                height: 120,
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
              ),
            if(!_isblue)
              AnimatedContainer(
                duration: Duration(seconds: 2),
                color: Colors.cyan,
                height: 120,
                margin: EdgeInsets.all(10),
              ),
            ElevatedButton(onPressed: (){
              setState(() {
              _isblue=!_isblue;
            });
            }, child: Text("change"),)
          ],
        ),
      ),
    );
  }
}
