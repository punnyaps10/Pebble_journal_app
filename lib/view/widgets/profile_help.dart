import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const List<Map<String, String>> faqs = [
    {
      'question': 'How do I create a journal entry?',
      'answer': "Tap the yellow '+' button on the bottom tab bar and start writing."
    },
    {
      'question': 'How do I edit my profile?',
      'answer': 'Go to Profile > Edit Profile and update your name, photo, or email.'
    },
    {
      'question': 'How do I delete an entry?',
      'answer': 'Open the entry, tap the menu icon, then select Delete.'
    },
    {
      'question': 'Is my data backed up?',
      'answer': "Yes, entries sync automatically once you're signed in."
    },
    
  ];

  static const Color background = Color(0xFFFAF7EE);
  static const Color accent = Color(0xFFF5C859);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: background,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...faqs.map((faq) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq['question']!,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      faq['answer']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 30),
          const Text('Still need help?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),

        
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Contact Support', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}