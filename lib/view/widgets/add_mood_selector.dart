import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/mood_data.dart';

class MoodSelector extends StatelessWidget {
  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 235, 163),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'How you are feeling?',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: moodImages.entries.map((entry) {
              final mood = entry.key;
              final imagePath = entry.value;
              final isSelected = selectedMood == mood;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () => onMoodSelected(mood),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          isSelected ? Colors.white : Colors.transparent,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(mood)
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}