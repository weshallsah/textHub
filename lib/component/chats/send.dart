import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Snd extends StatefulWidget {
  const Snd({super.key});

  @override
  State<Snd> createState() => _SndState();
}

class _SndState extends State<Snd> {

  final _controller = new TextEditingController();
  late var entermassage ='';
  void sndmassage(){
    
    _controller.clear();
    FirebaseFirestore.instance.collection('Chat').add({'Text':entermassage});
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
          IconButton(onPressed: entermassage.trim().isEmpty ? null : sndmassage
          , icon:const Icon(Icons.send))
        ],
      ),
    );
  }
}
