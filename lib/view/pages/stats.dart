import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/core/constants/emotions.dart';
import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/models/journal_model.dart';
import 'package:pebble_project/view/widgets/stats_emotion_card.dart';
import 'package:pebble_project/view/widgets/stats_top_mood_card.dart';
import 'package:pebble_project/view/widgets/stats_week_badge.dart';


class Stats extends StatelessWidget {
  const Stats({super.key});

  DateTimeRange _weekRange(DateTime now) {
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1)); 
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return DateTimeRange(start: startOfWeek, end: endOfWeek);
  }

  int _thisWeekCount(List<JournalEntry> allEntries) {
    final range = _weekRange(DateTime.now());
    return allEntries
        .where((e) =>
            e.dateTime.isAfter(range.start.subtract(const Duration(seconds: 1))) &&
            e.dateTime.isBefore(range.end))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder<List<JournalEntry>>(
          valueListenable: journalNotifier,
          builder: (context, allEntries, _) {
            final total = allEntries.length;
            final weekCount = _thisWeekCount(allEntries);

            final counts = <String, int>{};
            final percents = <String, double>{};
            for (final m in EmotionData.emotions) {
              final label = m['label'] as String;
              final count = allEntries.where((e) => e.mood == label).length;
              counts[label] = count;
              percents[label] = total == 0 ? 0.0 : count / total;
            }

            String? topMood;
            int topCount = 0;
            counts.forEach((mood, count) {
              if (count > topCount) {
                topCount = count;
                topMood = mood;
              }
            });

            final topMoodData = EmotionData.emotions.firstWhere(
              (m) => m['label'] == topMood,
              orElse: () => EmotionData.emotions[0],
            );

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Center(
                  child: Text('Your Mood Insights', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 14),

                WeekBadge(weekCount: weekCount),

                const SizedBox(height: 46),

                EmotionsCard(percents: percents),

                const SizedBox(height: 60),

                if (topMood != null)
                  TopMoodCard(
                    topMood: topMood!,
                    topCount: topCount,
                    topMoodData: topMoodData,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}