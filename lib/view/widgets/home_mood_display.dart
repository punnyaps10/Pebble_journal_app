import 'package:flutter/material.dart';

class MoodDisplay extends StatelessWidget {
  final String mood;
  const MoodDisplay({super.key, required this.mood});

  static const Map<String, String> moodImages = {
    
    'Sad': 'assets/sad_dog.jpg',
    'Calm': 'assets/calm_sheep.jpg',
    'Happy': 'assets/happy_cat.jpg',
    'Angry': 'assets/agry_frog.png',
  };

  

  @override
  Widget build(BuildContext context) {
    final imagePath = moodImages[mood] ?? moodImages['Happy']!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Text("My Mood Today", style: TextStyle(fontSize: 25)),
              const SizedBox(width: 8),
              
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
              
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}