import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authfrom extends StatefulWidget {
  const Authfrom({super.key});

  @override
  State<Authfrom> createState() => _AuthfromState();
}

class _AuthfromState extends State<Authfrom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(25),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email@ABC.com',
                        labelStyle: TextStyle(fontSize: 28)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(fontSize: 28)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'password',
                        labelStyle: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: 'Login pressed',fontSize: 20
                        );
                      },
                      child:
                          const Text("Login", style: TextStyle(fontSize: 28))),
                  TextButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "abhi nhi bana h gandu",fontSize: 20
                        );
                      },
                      child: const Text(
                        "Don't have account",
                        style: TextStyle(fontSize: 28),
                      ))
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
