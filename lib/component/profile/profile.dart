import 'package:flutter/material.dart';

class profilPage extends StatefulWidget {
  const profilPage({super.key});

  @override
  State<profilPage> createState() => _profilPageState();
}

String? profilepic;

class _profilPageState extends State<profilPage> {
  TextEditingController userName =
      TextEditingController(text: "one_direction_vishal");
  TextEditingController userEmail =
      TextEditingController(text: "vishalk74064@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 70,
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.only(left: 16),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 180,
              child: const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.blueGrey,
                child: Image(
                  image: NetworkImage(
                    'https://drive.google.com/file/d/1mPAkuooe8x8b-71mGGejs8BgHJZqhRt5/view?usp=share_link',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 350,
                    child: TextFormField(
                      controller: userName,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        // labelStyle: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 60,
                    width: 350,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: userEmail,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        // helperText: "One_direction_vishal",
                        // hintText: "vishalk74064@gmail.com",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextButton(
                      
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 28,color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
