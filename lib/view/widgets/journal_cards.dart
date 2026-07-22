
import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/mood_data.dart';
import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/models/journal_model.dart';
import 'package:pebble_project/view/pages/add_journal.dart';

// ignore: unused_element
class JournalCard extends StatelessWidget {
  final JournalEntry entry;
  final String dateLabel;
  const JournalCard({required this.entry, required this.dateLabel});

  void _showOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Journal Options'),
          content: const Text('What would you like to do with this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddJournal(entry: entry),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // close dialog
                await deleteJournalById(entry.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Journal deleted')),
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              moodImages[entry.mood] ?? 'assets/calm.png',
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dateLabel,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showOptions(context),
                      child: const Icon(Icons.more_horiz, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  entry.title?.isNotEmpty == true ? entry.title! : entry.mood,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
