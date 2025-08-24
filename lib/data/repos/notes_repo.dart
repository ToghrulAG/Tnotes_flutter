import 'package:hive/hive.dart';
import '../hive/hive_init.dart';
import '../models/note.dart';

abstract class NotesRepo {
  Future<List<Note>> getAll();

  Future<Note> create(Note note);
  Future<void> update(Note note);
  Future<void> delete(int id);
  Future<void> putMany(List<Note> notes);
}

class HiveNotesRepo implements NotesRepo {
  Box<Note> get _box => Hive.box<Note>(notesBoxKey);

  @override
  Future<List<Note>> getAll() async => _box.values.toList();

  @override
  Future<Note> create(Note note) async {
    await _box.put(note.id, note);
    return note;
  }

  @override
  Future<void> update(Note note) => _box.put(note.id, note);

  @override
  Future<void> delete(int id) => _box.delete(id);

  @override
  Future<void> putMany(List<Note> notes) async {
    await _box.putAll({for (final n in notes) n.id: n});
  }
}
