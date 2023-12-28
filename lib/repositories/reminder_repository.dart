import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:care_on/models/reminder_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderRepository {
  final CollectionReference reminderCollection =
      FirebaseFirestore.instance.collection('reminders');

  Stream<List<Reminder>> getReminders() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return reminderCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Reminder(
          userId: doc['userId'],
          reminderId: doc['reminderId'],
          description: doc['description'],
          needAlarm: doc['needAlarm'],
          onRepeat: doc['onRepeat'],
          reminderOn: doc['reminderOn'],
          timeStart: doc['timeStart'],
          title: doc['title'],
        );
      }).toList();
    });
  }

  Future<void> addReminder(Reminder reminder) async {
    await reminderCollection.doc(reminder.reminderId).set(reminder.toMap());
  }

  Future<void> deleteReminder(String reminderId) async {
    await reminderCollection.doc(reminderId).delete();
  }
}
