import 'dart:ffi';

import 'package:care_on/components/note_tile.dart';
import 'package:care_on/models/note_model.dart';
import 'package:care_on/presenters/note_presenter.dart';
import 'package:care_on/views/add_note_page.dart';
import 'package:care_on/views/home_page.dart';
import 'package:care_on/views/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NotePresenter _presenter = NotePresenter();
  List<Note> notesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeNotes();
  }

  void _initializeNotes() {
    _presenter.getNotes().listen((List<Note> notes) {
      setState(() {
        notesList = notes;
      });
    });
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
          "GHI CHÚ",
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
                    builder: (context) => AddNotePage(),
                  ));
            },
          ),
        ),
      ),
      body: notesList.isEmpty
          ? Center(
              child: Text(
                "Hãy thêm ghi chú để theo dõi nhé!",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: notesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NoteTile(note: notesList[index]);
                },
              ),
            ),
    ));
  }
}
