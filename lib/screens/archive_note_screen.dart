import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/note.dart';
import '../state/notes_controller.dart';

class ArchiveNoteScreen extends ConsumerWidget {
  const ArchiveNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    List<Note> archivedNotes = [];

    if (notes is AsyncData<List<Note>>) {
      archivedNotes = notes.value.where((n) => n.isArchived).toList();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Archive'), centerTitle: true),
      body: archivedNotes.isEmpty
          ? Center(child: Text('Empty'))
          : Center(child: Text('data')),
    );
  }
}
