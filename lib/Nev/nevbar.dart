import 'package:chatbot/component/profile/profile.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:chatbot/screen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NevBar extends StatefulWidget {
  const NevBar({super.key});

  @override
  State<NevBar> createState() => _NevBarState();
}

class _NevBarState extends State<NevBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static List<Widget> _widgetOptions = <Widget>[
    chatBox(),
    searchPage(),
    profilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final nevhight = screensize.height * 0.085;
    final nevwidth = screensize.width * 0.792;
    print(screensize.width);
    print(nevwidth);
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: nevhight,
        width: nevwidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(1))
          ],
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        // color: Colors.amber,
        margin: EdgeInsets.only(
            left: screensize.width * 0.104,
            right: screensize.width * 0.104,
            bottom: screensize.height * 0.058),
        // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: SafeArea(
          child: GNav(
            tabBorderRadius: 30,
            // tabActiveBorder:Border.all(color: Colors.white, width: 1), // tab button border
            // tabBorder: Border.all(color: Colors.black, width: 1),
            tabShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 29, 29, 29).withOpacity(0.5),
                  blurRadius: 8)
            ],
            gap: 4,
            duration: Duration(milliseconds: 500),
            rippleColor: Colors.grey,
            hoverColor: Colors.grey,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textStyle:
                    TextStyle(fontFamily: "poppins", color: Colors.white),
              ),
              // GButton(icon: Icons.favorite,text: "like",),
              GButton(
                icon: Icons.search,
                text: "search",
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textStyle:
                    TextStyle(fontFamily: "poppins", color: Colors.white),
              ),
              GButton(
                icon: Icons.person,
                text: "profile",
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textStyle:
                    TextStyle(fontFamily: "poppins", color: Colors.white),
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (value) {
              setState(() {
                _selectedIndex = value;
              });
              // print(_selectedIndex);
            },
          ),
        ),
      ),
    );
  }
}
