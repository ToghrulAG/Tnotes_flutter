import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_flutter/screens/add_note_screen.dart';
import 'package:notes_flutter/screens/trash_box_screen.dart';
import '../../../state/notes_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
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
                itemCount: list.length,
                itemBuilder: (_, index) {
                  final note = list[index];
                  return ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(notesProvider.notifier).toTrash(note);
                  
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: const Color.fromARGB(255, 136, 60, 55),
                      ),
                    ),
                    title: Text(note.title),
                    subtitle: Text(
                      note.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
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
