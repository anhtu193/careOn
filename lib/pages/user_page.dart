import 'package:care_on/pages/edit_user_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:care_on/pages/chat_bot_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void toEditUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditUserPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Colors.black,
                onPressed: toEditUserPage,
              ),
            )
          ],
          title: Text(
            "HỒ SƠ",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          )),
    ));
  }
}
