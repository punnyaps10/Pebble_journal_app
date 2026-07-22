



import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';


class DatePickerCard extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;

  const DatePickerCard({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  String _formatDate(DateTime dt) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColor.containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 20),
            const SizedBox(width: 10),
            Text(
              _formatDate(selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}






