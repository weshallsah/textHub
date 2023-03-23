import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImg extends StatefulWidget {
  final void Function(File Img) imgpkg;
  // final _islogin;
  const PickImg(this.imgpkg);

  @override
  State<PickImg> createState() => _PickImgState();
}

class _PickImgState extends State<PickImg> {
  File? _img;
  void _pickImg() async {
    final pickedimgfile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _img = File(pickedimgfile!.path);
    });
    widget.imgpkg(_img!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          // !widget._islogin?
          Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: _img != null ? FileImage(_img!) : null,
          ),
          TextButton(
            onPressed: _pickImg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.image),
                Text(
                  "add image",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
