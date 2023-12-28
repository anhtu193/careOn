import 'package:care_on/pages/tabs/info_tab.dart';
import 'package:care_on/pages/tabs/video_tab.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:care_on/pages/chat_bot_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            backgroundColor: Color(0xffF4F6FB),
            elevation: 0,
            title: Text(
              "TRA CỨU",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.book,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.ondemand_video,
                  color: Colors.black,
                ),
              )
            ]),
            Expanded(
                child: TabBarView(
              children: [
                InfoTab(),
                VideoTab(),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
