import 'package:care_on/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateNote(Note note) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String? noteId = note.noteId.isNotEmpty
          ? note.noteId
          : _firestore.collection('notes').doc().id;

      note = Note(
        userId: userId,
        noteId: noteId,
        createdOn: Timestamp.now(),
        content: note.content.replaceAll('\n', '<br>'),
        noteColor: note.noteColor,
        title: note.title,
      );

      await _firestore.collection('notes').doc(noteId).set(note.toMap());
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Stream<List<Note>> getNotes() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Note(
                userId: doc['userId'],
                noteId: doc['noteId'],
                title: doc['title'],
                content: _processTextWithLineBreaks(doc['content']),
                noteColor: doc['noteColor'],
                createdOn: doc['createdOn'],
              );
            }).toList());
  }

  String _processTextWithLineBreaks(String inputText) {
    return inputText.replaceAll("<br>", "\n");
  }
}
