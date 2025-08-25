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
  Future <void> create(Note note) async {
    final repo = ref.read(notesRepoProvider);
    await repo.create(note);
    await refresh();
  }
}