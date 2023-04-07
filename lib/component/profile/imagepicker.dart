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
  // bool ison=true;
  File? _img;
  void _pickImg(String? _Source) async {
    print("clicked");
    if(_Source == "gallery"){
      final pickedimgfile =
        await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 20);
    setState(() {
      _img = File(pickedimgfile!.path);
      // ison=!ison;
    });
    widget.imgpkg(_img!);
    }
    else{
      final pickedimgfile =
        await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 20);
    setState(() {
      _img = File(pickedimgfile!.path);
      // ison=!ison;
    });
    widget.imgpkg(_img!);
    }
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
          // if(ison)
          TextButton(
            onPressed: (){
              showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 700),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 12,
                                  right: 12,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(197, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 80,
                                      width: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          _pickImg("gallery");
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.filter,
                                              size: 50,
                                            ),
                                            Text(
                                              "gallery",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 80,
                                      width: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          _pickImg("Camera");
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.camera,
                                              size: 50,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        );
            },
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
