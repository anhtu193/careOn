import 'package:care_on/pages/chat_bot_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: GestureDetector(
              child: Text("LOGGED IN"),
              onTap: signUserOut,
            )),
            Center(
              child: GestureDetector(
                child: Text("To chatbot"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatBotPage(),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
