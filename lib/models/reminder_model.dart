import 'package:flutter/material.dart';

class Reminder {
  final String reminderId;
  final String userId;
  final String title;
  final String description;
  final String timeStart;
  final String reminderOn;
  final bool onRepeat;
  final bool needAlarm;

  Reminder(
      {required this.reminderId,
      required this.userId,
      required this.title,
      required this.description,
      required this.timeStart,
      required this.reminderOn,
      required this.onRepeat,
      required this.needAlarm});

  Map<String, dynamic> toMap() {
    return {
      'reminderId': reminderId,
      'userId': userId,
      'title': title,
      'description': description,
      'timeStart': timeStart,
      'reminderOn': reminderOn,
      'onRepeat': onRepeat,
      'needAlarm': needAlarm,
    };
  }
}
