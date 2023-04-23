import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/screen/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

final ChatId = const Uuid();

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController Searchuser = TextEditingController();
  String? ChatRoomid;

  void getchatRoom(
      String uid, String username, String Pic, String notiID) async {
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
        'Ismess': false,
        'notiID': notiID,
        'FrndConver': {
          uid: true,
          myuid: true,
        },
      });
      print("get in chatid");
      print(ChatRoomid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              // color: Colors.amber,
              // height: 60,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(
                        top: 30, bottom: 15, left: 10, right: 10),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.amber,
                    ),
                    child: TextField(
                      controller: Searchuser,
                      textAlign: TextAlign.center,
                      cursorHeight: 30,
                      cursorRadius: const Radius.circular(20),
                      decoration: InputDecoration(
                        hintText: "search email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 100, right: 100),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "search",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                      // print(Searchuser.text);
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .where("Email", isEqualTo: Searchuser.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          final searchuser = snapshot.data?.docs;
                          if (searchuser != null && searchuser.length > 0) {
                            print(searchuser);
                            return ListView.builder(
                              itemCount: searchuser.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    // backgroundColor: Colors.amber,
                                    backgroundImage: searchuser[index]
                                                ['profile_img_url'] !=
                                            null
                                        ? NetworkImage(searchuser[index]
                                            ['profile_img_url'])
                                        : null,
                                  ),
                                  title: Text(searchuser[index]['Username']),
                                  subtitle: Text(searchuser[index]['Email']),
                                  onTap: () async {
                                    await Future(() => getchatRoom(
                                        searchuser[index]['uid'],
                                        searchuser[index]['Username'],
                                        searchuser[index]['profile_img_url'],
                                        searchuser[index]['Noti_Id']));
                                    print("checking before chatroom");
                                    print(ChatRoomid);
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => chatRoom(
                                          RoomId: ChatRoomid,
                                          username: searchuser[index]
                                              ['Username'],
                                          userPic: searchuser[index]
                                              ['profile_img_url'],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return const Text("NO User Found");
                          }
                        } else {
                          return const Text("NO user found");
                        }
                      } else {
                        return const Text("No user found");
                      }
                    }),
              ),
            )
          ],
        ));
  }
}
