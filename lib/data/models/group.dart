import 'package:hive/hive.dart';
part 'group.g.dart';

@HiveType(typeId: 2) 
class Group extends HiveObject {
  @HiveField(0) int id;
  @HiveField(1) String name;
  @HiveField(2) DateTime createdAt;

  Group({
    required this.id,
    required this.name,
    required this.createdAt
  });
}