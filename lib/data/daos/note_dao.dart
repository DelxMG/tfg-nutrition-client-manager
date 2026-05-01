import 'package:drift/drift.dart';
import 'package:nutritrack/domain/enums.dart';

import '../db/app_database.dart';
import '../db/tables/notes.dart';

part 'note_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NoteDao extends DatabaseAccessor<AppDatabase> with _$NoteDaoMixin {
  NoteDao(super.db);

  Future<int> insertNote({
    required int clientId,
    required String content,
    NoteType type = NoteType.general,
    DateTime? date,
  }) {
    return into(notes).insert(
      NotesCompanion.insert(
        clientId: clientId,
        content: content,
        type: Value(type),
        date: Value(date ?? DateTime.now()),
      ),
    );
  }

  Future<bool> updateNote(Note note) {
    return update(notes).replace(note);
  }

  Future<int> deleteNote(int noteId) {
    return (delete(notes)..where((tbl) => tbl.noteId.equals(noteId))).go();
  }

  Future<Note?> getNoteById(int noteId) {
    return (select(notes)..where((tbl) => tbl.noteId.equals(noteId)))
        .getSingleOrNull();
  }

  Stream<List<Note>> watchNotesByClientId(int clientId) {
    return (select(notes)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .watch();
  }
}
