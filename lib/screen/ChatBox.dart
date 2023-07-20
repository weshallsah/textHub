import 'package:chatbot/component/chats/ChatRoom/chatRoom.dart';
import 'package:chatbot/component/profile/profile.dart';
import 'package:chatbot/screen/searchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
  // Map<String,dynamic>? Frindid;
  String? roomId;

  

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
    // print('geting data: $docs');
  }

  

  

  @override
  void initState() {
    getData();
    // getMessage();

    super.initState();
  }

  void _isedited(bool isEdit) {
    getData();
  }

  String RoomID = '';

  @override
  Widget build(BuildContext context) {
    // String _Date = DateFormat.LLL().toString();
    // print(DateFormat.d().format(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.menu,color: colors.,),
        
        backgroundColor: Colors.white54,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Chathub',style: TextStyle(fontSize: 24),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        // backgroundColor: Colors.black,
        
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
      body: SafeArea(
        // color: Colors.amber,

        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chat')
                .where(docs.toString(), isEqualTo: true)
                .where("Ismess", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final FrndList = snapshot.data?.docs;
                  if (FrndList != null && FrndList.length > 0) {
                    return ListView.builder(
                      itemCount: FrndList.length,
                      itemBuilder: (context, index) {
                        roomId = FrndList[index]['ChatRoomId'];
                        Map Frindid = FrndList[index]['FrndConver'];
                        String? uid;
                        Frindid.forEach(
                          (key, value) => {
                            if (key != myuid) {uid = key}
                          },
                        );
                        // print(uid);
                        // final mynotification = FrndList[index]['NotificationID'][''];
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 10, right: 8, top: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              // radius: 40,
                              backgroundImage:
                                  FrndList[index]['ProfImg'] != null
                                      ? NetworkImage(FrndList[index]['ProfImg'])
                                      : null,
                            ),
                            title: Text(
                              FrndList[index]['Username'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
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
                                    userID: uid,
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
                return const Center(
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
              builder: (context) => const searchPage(),
            ),
          );
          // shownotifi("vishal", "hello");
          // LocalNotification().shownotification("title", "body", 'item x');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
