import 'package:care_on/models/note_model.dart';
import 'package:care_on/repositories/note_repository.dart';

class NotePresenter {
  final NoteRepository _repository = NoteRepository();

  Future<void> addOrUpdateNote(Note note) async {
    await _repository.addOrUpdateNote(note);
  }

  Future<void> deleteNote(String noteId) async {
    await _repository.deleteNote(noteId);
  }

  Stream<List<Note>> getNotes() {
    return _repository.getNotes();
  }
}
