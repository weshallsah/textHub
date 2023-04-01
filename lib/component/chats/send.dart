import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Snd extends StatefulWidget {
  const Snd({super.key});

  @override
  State<Snd> createState() => _SndState();
}

class _SndState extends State<Snd> {
  
  
  final _controller = new TextEditingController();
  late var entermassage = '';
  
  
  void sndmassage() async{
    final auth = await FirebaseAuth.instance.currentUser;
    final user=await FirebaseFirestore.instance.collection('user').doc(auth?.uid).get();
    _controller.clear();
    FirebaseFirestore.instance.collection('Chat').add({
      'Text': entermassage,
      'Createdat': Timestamp.now(),
      'UserId': auth?.uid,
      'Username': user['Username'],
      'userProf':user['profile_img_url'],
    });
    // FirebaseDatabase.instance.ref('Chat').child(Timestamp.now() as String).set({
    //   'Text': entermassage,
    //   // 'Createdat': ,
    //   'UserId': auth?.uid,
    //   'Username': user['Username'],
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: '...',
              ),
              onChanged: (value) {
                setState(() {
                  entermassage = value.trim();
                });
              },
              controller: _controller,
            ),
          ),
          IconButton(
              onPressed: entermassage.trim().isEmpty ? null : sndmassage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
