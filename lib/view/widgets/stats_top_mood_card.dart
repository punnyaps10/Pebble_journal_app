import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

class TopMoodCard extends StatelessWidget {
  final String topMood;
  final int topCount;
  final Map<String, dynamic> topMoodData;

  const TopMoodCard({
    super.key,
    required this.topMood,
    required this.topCount,
    required this.topMoodData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 247, 222),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage(topMoodData['image'] as String),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Most Frequent Mood',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(topMood, style: const TextStyle(fontSize: 24)),
                Text(
                  '$topCount entries',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 101, 101, 101),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}