import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/emotions.dart';
import 'package:pebble_project/view/widgets/stats_graphbar.dart';

class EmotionsCard extends StatelessWidget {
  final Map<String, double> percents;
  const EmotionsCard({super.key, required this.percents});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Emotions', style: TextStyle(fontSize: 25)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: EmotionData.emotions.map((m) {
              final label = m['label'] as String;
              final percent = percents[label]!;
              final displayPercent = '${(percent * 100).round()}%';

              return Column(
                children: [
                  Moodbar(
                    percent: percent,
                    color: m['color'] as Color,
                    displayPercent: displayPercent,
                  ),
                  const SizedBox(height: 10),
                  Text(label, style: const TextStyle(fontSize: 15)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}