import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/component/chats/massage.dart';
import 'package:chatbot/component/chats/send.dart';
import 'package:chatbot/component/profile/profile.dart';
import 'package:chatbot/screen/searchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class chatBox extends StatefulWidget {
  chatBox();

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  String? userName = '';
  String? profilimage = '';
  String? myuid = '';
  String? docs;

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            userName = snapshot.data()!['Username'];
            profilimage = snapshot.data()!['profile_img_url'];
            myuid = snapshot.data()!['uid'];
          });
        }
      },
    );
    docs = 'FrndConver.${myuid}';
    print(docs);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void _isedited(bool isEdit) {
    getData();
  }

  String RoomID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            // underline: ,
            dropdownColor: Theme.of(context).hoverColor,
            icon: const Icon(Icons.more_vert),
            onChanged: (itemidentifier) {
              if (itemidentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Container(
                  // color: Color.fromARGB(230, 3, 168, 244),
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        // backgroundColor: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 142, 196, 240)),
            child: Column(
              children: [
                SizedBox(height: 5),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        profilimage != null ? NetworkImage(profilimage!) : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(userName!,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
          const Divider(thickness: .06, color: Color.fromARGB(255, 30, 29, 29)),
          ListTile(
            iconColor: Colors.blueAccent,
            leading: const Icon(Icons.person),
            title:
                const Text('My Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profilePage(_isedited),
                ),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blueAccent,
            leading: const Icon(Icons.settings),
            title: const Text('Setting', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Add Navigation logic here
            },
          ),
          ListTile(
            iconColor: Colors.blueAccent,
            leading: const Icon(Icons.question_mark),
            title: const Text('About', style: TextStyle(color: Colors.black)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "ChatBox",
                applicationVersion: "0.0.2",
                // useRootNavigator:
                children: [
                  const Text("app is under devlopment"),
                ],
              );
            },
          ),
        ]),
      ),
      // body: Container(
      //   child: Column(
      //     children: const [
      //       Expanded(
      //         child: Massage(),
      //       ),
      //       Snd(),
      //     ],
      //   ),
      // ),
      //
      //
      body: SafeArea(
        // color: Colors.amber,

        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chat')
                .where(docs.toString(), isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final FrndList = snapshot.data?.docs;
                  if (FrndList != null && FrndList.length > 0) {
                    return ListView.builder(
                      itemCount: FrndList.length,
                      itemBuilder: (context, index) {
                        final roomId = FrndList[index]['ChatRoomId'];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  FrndList[index]['ProfImg'] != null
                                      ? NetworkImage(FrndList[index]['ProfImg'])
                                      : null,
                            ),
                            title: Text(
                              FrndList[index]['Username'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // subtitle: Text(""),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => chatRoom(
                                    RoomId: roomId,
                                    userPic: FrndList[index]['ProfImg'],
                                    username: FrndList[index]['Username'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => searchPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
