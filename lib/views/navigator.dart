import 'package:care_on/views/chat_bot_page.dart';
import 'package:care_on/views/home_page.dart';
import 'package:care_on/views/library_page.dart';
import 'package:care_on/views/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;

  //navigate around tabs
  void navigate(int index) {
    if (index >= 0 && index < pages.length) {
      setState(() {
        selectedIndex = index;
        print(index);
      });
    }
  }

  final List<Widget> pages = [
    HomePage(),
    ChatBotPage(),
    LibraryPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
          hoverColor: Colors.blue.shade100,
          backgroundColor: Color(0xff3AB5FF),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white30,
          selectedIndex: selectedIndex,
          onTabChange: navigate,
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Trang chủ",
            ),
            GButton(icon: Icons.chat_bubble, text: "Chat"),
            GButton(icon: Icons.book, text: "Tra cứu"),
            GButton(icon: Icons.account_circle, text: "Hồ sơ")
          ]),
      body: pages[selectedIndex],
    );
  }
}
