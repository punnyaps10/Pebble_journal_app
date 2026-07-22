import 'package:flutter/material.dart';

// ignore: unused_element
class Moodbar extends StatelessWidget {
  final double percent;
  final Color color;
  final String displayPercent;

  const Moodbar({super.key, 
    
    required this.percent,
    required this.color,
    required this.displayPercent,
  });

  static const double barHeight = 220;
  static const double barWidth = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: barHeight,
      width: barWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: barHeight,
            width: barWidth,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
          ),

          Container(
            height: barHeight * percent,
            width: barWidth,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              displayPercent,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
