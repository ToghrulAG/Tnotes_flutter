import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_flutter/data/models/note.dart';
import '../../../state/notes_controller.dart';

class TrashBoxScreen extends ConsumerStatefulWidget {
  const TrashBoxScreen({super.key});

  @override
  ConsumerState<TrashBoxScreen> createState() => _TrashBoxScreenState();
}

class _TrashBoxScreenState extends ConsumerState<TrashBoxScreen> {
  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(notesProvider);

    List<Note> trashedNotes = [];

    if (notes is AsyncData<List<Note>>) {
      trashedNotes = notes.value.where((n) => n.isTrashed).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Trash Box'), centerTitle: true),
      body: trashedNotes.isEmpty
          ? Center(child: Text('Trash Box is empty'))
          : ListView.builder(
              itemCount: trashedNotes.length,
              itemBuilder: (context, index) {
                final note = trashedNotes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.delete_forever), Icon(Icons.restore)],
                  ),
                );
              },
            ),
    );
  }
}
