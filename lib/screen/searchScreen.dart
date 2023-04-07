import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final ChatId = Uuid();

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController Searchuser = TextEditingController();
  String? ChatRoomid;

  void getchatRoom(String uid, String username, String Pic) async {
    final myuid = FirebaseAuth.instance.currentUser?.uid;
    final Room = await FirebaseFirestore.instance
        .collection('Chat')
        .where('FrndConver.${uid}', isEqualTo: true)
        .where('FrndConver.${myuid}')
        .get();
    if (Room.docs.length > 0) {
      ChatRoomid = await Room.docs[0].data()['ChatRoomId'];
    } else {
      ChatRoomid = ChatId.v1();
      await FirebaseFirestore.instance.collection('Chat').doc(ChatRoomid).set({
        'Username': username,
        'ProfImg': Pic,
        'ChatRoomId': ChatRoomid,
        'FrndConver': {
          uid: true,
          myuid: true,
        },
      });
      print(ChatRoomid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            const SizedBox(
              height: 18,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: Searchuser,
                cursorHeight: 28,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: "search useremail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                    gapPadding: 12,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      25,
                    ),
                  ),
                ),
                child: const Text(
                  // textAlign: TextAlign.center,
                  "Search",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 40,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .where('Email', isEqualTo: Searchuser.text)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    final Frnd = snapshot.data?.docs;
                    if (Frnd != null && Frnd.length > 0) {
                      print(Frnd);

                      return SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 450,
                          width: double.infinity,
                          // color: Colors.amber,
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage: Frnd[0]['profile_img_url'] !=
                                        null
                                    ? NetworkImage(Frnd[0]['profile_img_url'])
                                    : null,
                              ),
                              title: Text(
                                Frnd[0]['Username'],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                Frnd[0]['Email'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () async {
                                await Future(() => getchatRoom(
                                      Frnd[0]['uid'],
                                      Frnd[0]['Username'],
                                      Frnd[0]['profile_img_url'],
                                    ));

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        chatRoom(RoomId: ChatRoomid),
                                  ),
                                );
                              }
                              // onTap: ,
                              ),
                        ),
                      );
                    } else {
                      return const Text("No User found");
                    }
                  } else if (snapshot.hasError) {
                    return Text("check the user email");
                  } else {
                    return Text("No result");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
