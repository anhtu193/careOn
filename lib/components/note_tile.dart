import 'package:care_on/models/note_model.dart';
import 'package:care_on/pages/add_note_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatefulWidget {
  Note note;
  NoteTile({super.key, required this.note});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  String convertTimestampToString(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage.existed(widget.note),
            ));
      },
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            color: Color(int.parse("0xff" + widget.note.noteColor)),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                offset: Offset(0, 4),
                blurRadius: 2,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35.79,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Center(
                  child: Text(
                convertTimestampToString(widget.note.createdOn),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Text(
                widget.note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Text(
                widget.note.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.3, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
