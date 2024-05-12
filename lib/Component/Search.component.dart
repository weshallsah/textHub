import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.0641,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
          style: BorderStyle.solid,
          // strokeAlign: 0
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 35,
          ),
          hintText: "Search",
        ),
        style: TextStyle(fontSize: 18),
        // textAlign: TextAlign.center,
        onChanged: (value) {},
      ),
    );
  }
}
