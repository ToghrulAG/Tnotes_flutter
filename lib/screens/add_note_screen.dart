import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_flutter/data/models/note.dart';
import '../../../state/notes_controller.dart';
import 'package:hive/hive.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //
              final title = titleController.text;
              final content = contentController.text;
              final id = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
              final note = Note(
                id: id,
                title: title,
                content: content,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              //
              ref.read(notesProvider.notifier).create(note);

              final box = Hive.box<Note>('notes_box');
              print('All notes: ${box.values.toList()}');
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(fontSize: 24),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TextField(
              expands: true,
              maxLines: null,
              minLines: null,
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'Content',
                hintStyle: TextStyle(fontSize: 17),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
