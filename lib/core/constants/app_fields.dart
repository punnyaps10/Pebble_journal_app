import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

class AppFields extends StatelessWidget {
  final String label;
  final String? hintText;
  final int maxLines;
  final TextEditingController? controller;

  const AppFields({
    super.key,
    required this.label,
    this.hintText,
    this.maxLines=1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text
      (label, 
      style: const TextStyle(fontSize: 16)
      ),
      const SizedBox(height: 10),

      TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColor.containerColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
          )
        ),
      ),
      
    ],
    
      
    );
  }
}
