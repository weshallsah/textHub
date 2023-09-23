import 'package:chatbot/component/listFrnd.dart';
import 'package:chatbot/component/sreach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chatBox extends StatefulWidget {
  final drag_, docs, Myuid;
  const chatBox({
    super.key,
    this.drag_,
    this.docs,
    this.Myuid,
  });

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: widget.drag_ ? const Radius.circular(0) : Radius.circular(41.r),
            topRight: widget.drag_ ? const Radius.circular(0) : Radius.circular(41.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const searchBox(),
            ListFrnd(
              docs: widget.docs,
              myuid: widget.Myuid,
              isarchiv: false,
            ),
          ],
        ),
      ),
    );
  }
}
