import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DatabaseAuth {
  final _auth = FirebaseAuth.instance;
  void FireAuth(String Firstname, String Lastname, String email,
      String password, String username, bool islogin) async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    // ignore: non_constant_identifier_names
    UserCredential Futher;
    // var imgurl;
    try {
      if (islogin) {
        Futher = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(Futher.user?.uid)
            .update(
          {
            'Noti_Id': fcmToken,
          },
        );
      } else {
        Futher = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var isverify = Futher.user?.emailVerified;
        isverify = false;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(Futher.user?.uid)
            .set(
          {
            'Noti_Id': fcmToken,
            'firstname': Firstname,
            'lastname': Lastname,
            'Username': username,
            'Email': email,
            'Avtar_URL':
                "https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2Fcommanprofileavtar.png?alt=media&token=b9791391-f85a-4e01-be99-ae7fd7f0dd7d",
            'uid': Futher.user?.uid,
          },
        ).whenComplete(() => null);
      }
    } on PlatformException catch (err) {
      var errMassage = "please enter valid cerdential";
      if (err.message != null) {
        errMassage = err.message as String;
      }
    } catch (err) {
      print(err);
    }
  }

  void forget(String Email) {
    _auth.sendPasswordResetEmail(email: Email);
  }

  void logout() {
    _auth.signOut();
  }

  void delete() {
    _auth.currentUser?.delete();
  }
}

class databasestore {
  final fireStrore = FirebaseFirestore.instance;
  final Auth = FirebaseAuth.instance.currentUser?.uid;

  // void avtar
  void updata(String Firstname, String Lastname, String username, String email,
      String About) async {
    await fireStrore.collection('user').doc(Auth).update(
      {
        'firstname': Firstname,
        'lastname': Lastname,
        'Username': username,
        'Email': email,
        'about': About,
        'Avtar_URL':
            "https://firebasestorage.googleapis.com/v0/b/chatbox-1cbb4.appspot.com/o/avtar%2Fcommanprofileavtar.png?alt=media&token=b9791391-f85a-4e01-be99-ae7fd7f0dd7d",
      },
    ).whenComplete(() => null);
  }

  void fetchdata(
      TextEditingController Firstname,
      TextEditingController Lastname,
      TextEditingController email,
      TextEditingController username,
      TextEditingController about) async {
    await fireStrore.collection('user').doc(Auth).get().then(
      (value) {
        Firstname.text = value['firstname'];
        Lastname.text = value['lastname'];
        email.text = value['Email'];
        username.text = value['Username'];
        about.text = value['about'];
      },
    );
  }

  void uploadAvtar(String URL) {
    // print(URL);
    fireStrore.collection('user').doc(Auth).update(
      {
        'Avtar_URL': URL,
      },
    );
  }

  void delete() async {
    await fireStrore.collection('user').doc(Auth).delete();
  }
}
