


import 'package:flutter/material.dart';

class Moodcard extends StatelessWidget {
  final String selectedMood;
  final Function(String) onMoodSelected;

  const Moodcard({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  static const Map<String, IconData> moods = {
    'Happy': Icons.sentiment_very_satisfied,
    'Sad': Icons.sentiment_dissatisfied,
    'Calm': Icons.sentiment_neutral,
    'Angry': Icons.sentiment_very_dissatisfied,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 201, 225, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: moods.entries.map((entry) {
          final mood = entry.key;
          final icon = entry.value;
          final isSelected = mood == selectedMood;

          return GestureDetector(
            onTap: () => onMoodSelected(mood),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor:
                      isSelected ? const Color.fromARGB(255, 4, 89, 168) : Colors.white,
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  mood,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? const Color.fromARGB(255, 4, 89, 168): Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}