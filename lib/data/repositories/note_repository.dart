import 'package:nutritrack/domain/enums.dart';

import '../daos/note_dao.dart';
import '../db/app_database.dart';

class NoteRepository {
  final NoteDao noteDao;

  NoteRepository(AppDatabase db) : noteDao = NoteDao(db);

  Future<int> insertNote({
    required int clientId,
    required String content,
    NoteType type = NoteType.general,
    DateTime? date,
  }) =>
      noteDao.insertNote(
        clientId: clientId,
        content: content,
        type: type,
        date: date,
      );

  Future<bool> updateNote(Note note) => noteDao.updateNote(note);

  Future<int> deleteNote(int noteId) => noteDao.deleteNote(noteId);

  Future<Note?> getNoteById(int noteId) => noteDao.getNoteById(noteId);

  Stream<List<Note>> watchNotesByClientId(int clientId) =>
      noteDao.watchNotesByClientId(clientId);
}
