import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

class SaveJournalButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const SaveJournalButton({
    super.key,
    required this.isEditing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          isEditing ? 'Update Journal' : 'Save Journal',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}