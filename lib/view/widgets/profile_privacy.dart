import 'package:flutter/material.dart';

class PrivacyCenterPage extends StatelessWidget {
  const PrivacyCenterPage({super.key});

  static const Color background = Color(0xFFFAF7EE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Privacy Center'),
        backgroundColor: background,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "We care about your privacy. Here's what data we collect and how you can manage it.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          _sectionCard(
            'Data We Collect',
            'Email address, profile photo, and journal entries you create in the app.',
          ),
          _sectionCard(
            'How We Use It',
            'To sync your entries across devices and personalize your experience. We never sell your data.',
          ),
          _sectionCard(
            'Third-Party Sharing',
            "We don't share your personal data with third parties, except anonymous analytics to improve the app.",
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          _navRow(context, 'Privacy Policy', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const _PlaceholderTextPage(
                  title: 'Privacy Policy',
                  body: 'Full Privacy Policy text goes here.',
                ),
              ),
            );
          }),
          _navRow(context, 'Terms of Service', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const _PlaceholderTextPage(
                  title: 'Terms of Service',
                  body: 'Full Terms of Service text goes here.',
                ),
              ),
            );
          }),
          _navRow(context, 'Download My Data', () {
            // dummy action - export data
          }),
          _navRow(
            context,
            'Delete My Account',
            () {
              // dummy action - delete account
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(String title, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _navRow(BuildContext context, String title, VoidCallback onTap,
      {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: isDestructive ? Colors.red : Colors.black),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderTextPage extends StatelessWidget {
  final String title;
  final String body;

  const _PlaceholderTextPage({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(body),
      ),
    );
  }
}