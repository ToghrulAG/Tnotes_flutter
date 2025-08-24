import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            DrawerHeader(child: const Text('Menu')),
            ListTile(onTap: () {}, title: const Text('Settings')),
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
                  final n = list[index];
                  return ListTile(
                    title: Text(n.title),
                    subtitle: Text(
                      n.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
