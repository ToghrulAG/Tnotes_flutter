import 'package:hive/hive.dart';
import '../hive/hive_init.dart';
import '../models/note.dart';

abstract class NotesRepo {
  Future<List<Note>> getAll();

  Future<Note> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(int id);
  Future<void> putManyNotes(List<Note> notes);
}

class HiveNotesRepo implements NotesRepo {
  Box<Note> get _box => Hive.box<Note>(notesBoxKey);

  @override
  Future<List<Note>> getAll() async => _box.values.toList();

  @override
  Future<Note> createNote(Note note) async {
    await _box.put(note.id, note);
    // await Hive.box<Note>('notes_box').clear();
    return note;
  }

  @override
  Future<void> updateNote(Note note) => _box.put(note.id, note);

  @override
  Future<void> deleteNote(int id) => _box.delete(id);

  @override
  Future<void> putManyNotes(List<Note> notes) async {
    await _box.putAll({for (final n in notes) n.id: n});
  }
}
