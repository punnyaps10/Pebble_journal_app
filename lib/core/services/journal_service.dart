import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/models/journal_model.dart';

ValueNotifier<List<JournalEntry>> journalNotifier = ValueNotifier([]);
Future<void> getAllJournal() async {
  final journalData = Hive.box<JournalEntry>('journals');
  final currentUser = currentUserNotifier.value;
  if (currentUser == null) {
    journalNotifier.value = [];
    return;
  }
  journalNotifier.value = journalData.values
      .where((e) => e.userId == currentUser.id)
      .toList();
}

Future<void> addJournal(JournalEntry addJournal) async {
  final journalData = Hive.box<JournalEntry>('journals');
  await journalData.add(addJournal);
  await getAllJournal();
}

Future<void> updateJournalById(String id, JournalEntry updatedEntry) async {
  final journalData = Hive.box<JournalEntry>('journals');
  final index = journalData.values.toList().indexWhere((e) => e.id == id);
  if (index != -1) {
    await journalData.putAt(index, updatedEntry);
    await getAllJournal();
  }
}

Future<void> deleteJournalById(String id) async {
  final journalData = Hive.box<JournalEntry>("journals");
  final index = journalData.values.toList().indexWhere((e) => e.id == id);
  if (index != -1) {
    await journalData.deleteAt(index);

    await getAllJournal();
  }
}
