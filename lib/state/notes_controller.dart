import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repos/notes_repo.dart';
import '../data/models/note.dart';

final notesRepoProvider = Provider<NotesRepo>((ref) => HiveNotesRepo());

final notesProvider =
    StateNotifierProvider<NotesController, AsyncValue<List<Note>>>(
      (ref) => NotesController(ref)..refresh(),
    );

class NotesController extends StateNotifier<AsyncValue<List<Note>>> {
  NotesController(this.ref) : super(AsyncValue.loading());
  final Ref ref;

  Future<void> refresh() async {
    final repo = ref.read(notesRepoProvider);
    final notes = await repo.getAll();
    state = AsyncValue.data(notes);
  }

  Future<void> create(Note note) async {
    final repo = ref.read(notesRepoProvider);
    await repo.createNote(note);
    await refresh();
  }

  Future<void> delete(int id) async {
    final repo = ref.read(notesRepoProvider);
    await repo.deleteNote(id);
    await refresh();
  }

  Future<void> toTrash(Note note) async {
    final trashedNote = note.copyWith(isTrashed: true);

    final repo = ref.read(notesRepoProvider);
    await repo.updateNote(trashedNote);

    await refresh();
  }
  Future <void> toArchive(Note note) async {
    final archivedNote = note.copyWith(isArchived: true);

    final repo = ref.read(notesRepoProvider);
    
    await repo.updateNote(archivedNote);
    await refresh();
  }
}
