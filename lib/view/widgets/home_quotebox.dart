import 'package:flutter/material.dart';




class Quotes extends StatelessWidget {
  final String currentQuote;
  final VoidCallback onRefresh;

  const Quotes({
    super.key,
    required this.currentQuote,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '"$currentQuote"',
              style: const TextStyle(
                fontSize: 18,
               
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh, color: Colors.deepPurple),
              label: const Text(
                'Refresh',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}