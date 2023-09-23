import 'package:chatbot/component/listFrnd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Archive extends StatefulWidget {
  final Myuid, Docs;
  const Archive({super.key, this.Myuid, this.Docs});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Text",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
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
        // titleSpacing: double.infinity,

        elevation: 0,
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 8) {
            // print("rigth");
            Navigator.pop(context);
          }
          // else if(details.delta.dx<-8){
          //   print("left");
          // }
        },
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 350,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                margin: const EdgeInsets.only(
                  top: 31,
                  left: 39,
                ),
                duration: const Duration(
                  milliseconds: 350,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: const Icon(
                          Icons.archive_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 14,
                      ),
                    ),
                    const Flexible(
                      flex: 2,
                      child: Text(
                        "Archive",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListFrnd(
                docs: widget.Docs,
                myuid: widget.Myuid,
                isarchiv: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
