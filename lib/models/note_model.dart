import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note {
  final String noteId;
  final String userId;
  final String title;
  final String content;
  final String noteColor;
  final Timestamp createdOn;

  Note(
      {required this.noteId,
      required this.userId,
      required this.title,
      required this.content,
      required this.noteColor,
      required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'userId': userId,
      'title': title,
      'content': content,
      'noteColor': noteColor,
      'createdOn': createdOn,
    };
  }
}
