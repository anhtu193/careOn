import 'package:care_on/models/reminder_model.dart';
import 'package:care_on/pages/add_reminder_page.dart';
import 'package:care_on/pages/navigator.dart';
import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<Reminder> reminderList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        backgroundColor: Color(0xffF4F6FB),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(),
                  ));
            },
            icon: Icon(Icons.arrow_back, size: 28)),
        title: Text(
          "NHẮC NHỞ",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 67.0,
        width: 67.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xff3AB5FF),
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReminderPage(),
                  ));
            },
          ),
        ),
      ),
    ));
  }
}
