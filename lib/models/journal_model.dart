import 'package:hive/hive.dart';
part 'journal_model.g.dart';

@HiveType(typeId: 0)
class JournalEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String mood;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final String? imagePath;

  @HiveField(6)
  final String userId;

  JournalEntry({
    required this.id,
    required this.mood,
    this.title,
    required this.content,
    required this.dateTime,
    this.imagePath,
    required this.userId,
  });
}
