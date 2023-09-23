// ignore: unused_import
import 'package:chatbot/component/chats/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class massagePop extends StatelessWidget {
  final _Massage;
  final _photourl;
  final _isme;
  const massagePop(this._Massage, this._isme, this._photourl, {super.key});
  // print()
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: _isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.amber,
          margin: const EdgeInsets.symmetric(
            horizontal: 63,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            // color: Colors.amber,
            color: const Color.fromARGB(102, 96, 125, 139),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              topLeft: Radius.circular(12.r),
              bottomLeft: _isme ? Radius.circular(14.r) : Radius.zero,
              bottomRight: !_isme ? Radius.circular(14.r) : Radius.zero,
            ),
          ),
          child: Text(
            _Massage,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 23,
          ),
          height: 34,
          width: 34,
          child: CircleAvatar(
            foregroundImage: NetworkImage(
              _photourl,
            ),
          ),
        ),
      ],
    );
  }
}

// child: Column(
//   mainAxisSize: MainAxisSize.max,
//   crossAxisAlignment:
//       _isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//   children: [
//     Flexible(
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: 64,
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: 15.w,
//           vertical: 14.h,
//         ),
//         decoration: BoxDecoration(
//           color: Color.fromARGB(102, 96, 125, 139),
//           border: Border.all(
//             color: Colors.white,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(12.r),
//             topLeft: Radius.circular(12.r),
//             bottomLeft: _isme ? Radius.circular(14.r) : Radius.zero,
//             bottomRight: !_isme ? Radius.circular(14.r) : Radius.zero,
//           ),
//         ),
//         child: Text(
//           _Massage,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 15.sp,
//               fontWeight: FontWeight.w400,
//               fontFamily: "Poppins"),
//         ),
//       ),
//     ),
//     Flexible(
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: 23,
//         ),
//         height: 34.h,
//         width: 34.h,
//         child: CircleAvatar(
//           foregroundImage: NetworkImage(
//             _photourl,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),

// AnimatedContainer(
//           duration: Duration(seconds: 1),
//           margin: !_isme
//               ? const EdgeInsets.only(left: 6)
//               : const EdgeInsets.only(right: 6),
//           child: Row(
//             // crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment:
//                 _isme ? MainAxisAlignment.end : MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 _username,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         AnimatedContainer(
//           duration: Duration(seconds: 2),
//           margin: _isme
//               ? const EdgeInsets.only(right: 6)
//               : const EdgeInsets.only(left: 6),
//           padding: const EdgeInsets.all(8.0),
//           constraints:
//               BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
//           decoration:  BoxDecoration(
//             color: _isme?Colors.blueGrey:Colors.deepPurple,
//             borderRadius: BorderRadius.only(
//               topRight: const Radius.circular(15),
//               topLeft: const Radius.circular(15),
//               bottomLeft: _isme?const Radius.circular(15):Radius.zero,
//               bottomRight: !_isme?const Radius.circular(15):Radius.zero,
//             ),
//           ),
//           // color: Colors.deepPurple[400],
//           child: Text(
//             _Massage,
//             // textAlign: _isme ? TextAlign.end : TextAlign.start,
//             style: const TextStyle(fontSize: 24, color: Colors.white),
//           ),
//         )
