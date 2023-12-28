// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:care_on/models/note_model.dart';
import 'package:care_on/presenters/note_presenter.dart';
import 'package:care_on/views/note_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  Note? existedNote;
  AddNotePage({super.key});
  AddNotePage.existed(Note note, {super.key}) {
    existedNote = note;
  }

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final NotePresenter _presenter = NotePresenter();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String timestamp = "";
  String noteColor = "";
  @override
  void initState() {
    super.initState();
    if (widget.existedNote != null) {
      titleController.text = widget.existedNote!.title;
      contentController.text = widget.existedNote!.content;
      timestamp = convertTimestampToString(widget.existedNote!.createdOn);
      noteColor = widget.existedNote!.noteColor;
    } else {
      timestamp = convertTimestampToString(Timestamp.now());
      noteColor = getRandomNoteColor();
    }
  }

  String getRandomNoteColor() {
    List<String> values = ['FFF69B', 'A1C8E9', 'F6C2D9', 'BCDFC9'];
    int randomIndex = Random().nextInt(4);
    return values[randomIndex];
  }

  String convertTimestampToString(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
  }

  void updateNoteToFirestore() {
    if (titleController.value.text.isEmpty ||
        contentController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập đủ thông tin Ghi chú!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ),
      );
    } else {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String? noteId;
      if (widget.existedNote == null) {
        noteId = FirebaseFirestore.instance.collection('notes').doc().id;
      } else {
        noteId = widget.existedNote!.noteId;
      }
      String content = contentController.text;
      Note newNote = Note(
          userId: userId,
          noteId: noteId,
          createdOn: Timestamp.now(),
          content: content.replaceAll('\n', '<br>'),
          noteColor: noteColor,
          title: titleController.text);

      _presenter.addOrUpdateNote(newNote).then((_) {
        print("Ghi chú đã được cập nhật với ID: $noteId");
        Navigator.pop(context);
      }).catchError((error) {
        print("Lỗi khi cập nhật ghi chú: $error");
      });
    }
  }

  void deleteNoteFromFirestore(String noteId) {
    _presenter.deleteNote(noteId).then((_) {
      print("Ghi chú đã được xóa với ID: $noteId");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Xóa ghi chú thành công!',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
      ));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotePage(),
        ),
      );
    }).catchError((error) {
      print("Lỗi khi xóa ghi chú: $noteId");
    });
  }

  void _confirmDeleteNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "XÓA GHI CHÚ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Bạn có chắc chắn xóa Ghi chú này không?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                deleteNoteFromFirestore(widget.existedNote!.noteId);
              },
              child: Text(
                'Xóa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffF4F6FB),
        title: Text(
          "Ghi chú",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(size: 28, color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          widget.existedNote == null
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    _confirmDeleteNote(context);
                  },
                  icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                updateNoteToFirestore();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: TextField(
              maxLines: null,
              controller: titleController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Tiêu đề"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: widget.existedNote != null
                ? Text(
                    convertTimestampToString(widget.existedNote!.createdOn),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xff868686)),
                  )
                : Text(timestamp,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xff868686))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 25),
            child: TextField(
              maxLines: null,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              controller: contentController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Bắt đầu soạn"),
            ),
          ),
        ],
      ),
    ));
  }
}
