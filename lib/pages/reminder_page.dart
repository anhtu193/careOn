import 'package:care_on/components/reminder_tile.dart';
import 'package:care_on/models/reminder_model.dart';
import 'package:care_on/noti.dart';
import 'package:care_on/pages/add_reminder_page.dart';
import 'package:care_on/pages/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<Reminder> reminderList = [];
  void getRemindersFromFirestore() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('reminders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        reminderList.clear();
        reminderList = snapshot.docs.map((DocumentSnapshot document) {
          return Reminder(
            userId: document['userId'],
            reminderId: document['reminderId'],
            description: document['description'],
            needAlarm: document['needAlarm'],
            onRepeat: document['onRepeat'],
            reminderOn: document['reminderOn'],
            timeStart: document['timeStart'],
            title: document['title'],
          );
        }).toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRemindersFromFirestore();
    // Noti.initialize(flutterLocalNotificationsPlugin);
    // for (int i = 0; i < reminderList.length; i++){

    // }
  }

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
      body: reminderList.isEmpty
          ? Center(
              child: Container(
                width: 300,
                child: Text(
                  "Hãy thêm nhắc nhở để theo dõi các hoạt động của bạn nhé!",
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              itemCount: reminderList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 28, right: 28),
                  child: ReminderTile(
                    reminder: reminderList[index],
                  ),
                );
              },
            ),
    ));
  }
}
