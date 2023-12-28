import 'dart:convert';

import 'package:care_on/models/reminder_model.dart';
import 'package:care_on/views/add_reminder_page.dart';
import 'package:flutter/material.dart';

class ReminderTile extends StatefulWidget {
  Reminder reminder;
  ReminderTile({super.key, required this.reminder});

  @override
  State<ReminderTile> createState() => _ReminderTileState();
}

class _ReminderTileState extends State<ReminderTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderPage.existed(widget.reminder),
            ));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.reminder.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      widget.reminder.description == ""
                          ? SizedBox()
                          : SizedBox(
                              height: 5,
                            ),
                      widget.reminder.description == ""
                          ? SizedBox()
                          : Text(
                              widget.reminder.description,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset("lib/images/time.png"),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Center(
                              child: Text(
                            widget.reminder.timeStart,
                            style: TextStyle(
                                color: Color(0xff667085),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 33,
                    width: 33,
                    child: Image.asset(widget.reminder.needAlarm == true
                        ? "lib/images/alarm_on.png"
                        : "lib/images/alarm_off.png"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("lib/images/calendar.png"),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    widget.reminder.reminderOn,
                    style: TextStyle(
                        color: Color(0xff667085),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
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
