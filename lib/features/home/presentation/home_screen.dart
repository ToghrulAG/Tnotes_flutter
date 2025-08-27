import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_flutter/screens/add_note_screen.dart';
import 'package:notes_flutter/screens/trash_box_screen.dart';
import '../../../state/notes_controller.dart';
import '../../../data/models/note.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    List<Note> activeNotes = [];

    if (notes is AsyncData<List<Note>>) {
      activeNotes = notes.value
          .where((n) => !n.isArchived && !n.isTrashed)
          .toList();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: const Center(
                child: Text('Menu', style: TextStyle(fontSize: 24)),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TrashBoxScreen()),
                );
              },
              title: const Text('Trash'),
              leading: Icon(Icons.delete),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Archive'),
              leading: Icon(Icons.archive),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: notes.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('Note Box is Empty'))
            : ListView.builder(
                itemCount: activeNotes.length,
                itemBuilder: (_, index) {
                  final note = activeNotes[index];
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: ValueKey(note.id),
                    background: Container(
                      color: Colors.blueGrey,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.archive),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.delete, color: Colors.white),
                          Text(
                            'Delete',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) => {
                      if (direction == DismissDirection.endToStart)
                        {ref.read(notesProvider.notifier).toTrash(note)}
                      else
                        {
                          // ARCHIVE
                        },
                    },
                    child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
