import 'package:hive_flutter/hive_flutter.dart';
import '../models/group.dart';
import '../models/note.dart';
//
const notesBoxKey = 'notes_box';
const groupBoxKey = 'group_box';
const settingsBoxKey = 'settings_box';

Future<void> initHive() async {
  await Hive.initFlutter();
  //
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(GroupAdapter());
  //
  await Future.wait([
    Hive.openBox<Note>(notesBoxKey),
    Hive.openBox<Group>(groupBoxKey),
    Hive.openBox(settingsBoxKey),
  ]);
}
