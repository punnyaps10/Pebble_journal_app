import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

class WeekBadge extends StatelessWidget {
  final int weekCount;
  const WeekBadge({super.key, required this.weekCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'This week: $weekCount ${weekCount == 1 ? 'entry' : 'entries'}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}