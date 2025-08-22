import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  DateTime updatedAt;
  @HiveField(5)
  int? groupId;
  @HiveField(6)
  bool isArchived;
  @HiveField(7)
  bool isTrashed;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.groupId,
    this.isArchived = false,
    this.isTrashed = false,
  });

  Note CopyWith({
    String? content,
    int? groupId,
    bool? isArchived,
    bool? isTrashed,
    DateTime? updatedAt,
  }) => Note(
    id: id,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt,
    updatedAt: updatedAt ?? DateTime.now(),
    groupId: groupId ?? this.groupId,
    isArchived: isArchived ?? this.isArchived,
    isTrashed: isArchived ?? this.isTrashed,
  );
}
