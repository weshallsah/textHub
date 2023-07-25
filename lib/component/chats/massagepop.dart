// ignore: unused_import
import 'package:chatbot/component/chats/massage.dart';
import 'package:flutter/material.dart';

class massagePop extends StatelessWidget {
  final _Massage;
  final _username;
  final _photourl;
  final _isme;
  const massagePop(this._Massage, this._username, this._isme,this._photourl);
  // print()
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          _isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          margin: !_isme
              ? const EdgeInsets.only(left: 6)
              : const EdgeInsets.only(right: 6),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                _isme ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                _username,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 2),
          margin: _isme
              ? const EdgeInsets.only(right: 6)
              : const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.all(8.0),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
          decoration:  BoxDecoration(
            color: _isme?Colors.blueGrey:Colors.deepPurple,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(15),
              topLeft: const Radius.circular(15),
              bottomLeft: _isme?const Radius.circular(15):Radius.zero,
              bottomRight: !_isme?const Radius.circular(15):Radius.zero,
            ),
          ),
          // color: Colors.deepPurple[400],
          child: Text(
            _Massage,
            // textAlign: _isme ? TextAlign.end : TextAlign.start,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        )
      ],
    );
  }
}
