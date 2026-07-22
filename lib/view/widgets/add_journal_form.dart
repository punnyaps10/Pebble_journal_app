import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/core/constants/app_fields.dart';

class JournalForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final VoidCallback? onAddPhoto;

  const JournalForm({
    super.key,
    required this.titleController,
    required this.contentController,
    this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFields(
            label: 'Title (optional)',
            controller: titleController,
          ),
          const SizedBox(height: 24),

          AppFields(
            label: 'Write your thoughts...',
            hintText: 'Start writing...',
            maxLines: 8,
            controller: contentController,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onAddPhoto,
              icon: const Icon(
                Icons.photo_outlined,
                color: Colors.black,
              ),
              label: const Text(
                'Add Photos',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.containerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}