import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/models/journal_model.dart';
import 'package:pebble_project/view/widgets/add_date_picking_card.dart';
import 'package:pebble_project/view/widgets/add_journal_form.dart';
import 'package:pebble_project/view/widgets/add_mood_selector.dart';
import 'package:pebble_project/view/widgets/add_save_journal.dart';
import 'package:uuid/uuid.dart';

class AddJournal extends StatefulWidget {
  final JournalEntry? entry;
  const AddJournal({super.key, this.entry});

  @override
  State<AddJournal> createState() => _AddJournalState();
}

class _AddJournalState extends State<AddJournal> {
  String? selectMood;
  DateTime selectedDate = DateTime.now();
  File? selectedImage;

  final uuid = Uuid();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool get isEditing => widget.entry != null;
  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final e = widget.entry!;
      selectMood = e.mood;
      selectedDate = e.dateTime;
      titleController.text = e.title ?? '';
      contentController.text = e.content;
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      selectedImage = File(image.path);
    });
  }

  void saveJournal() async {
    if (selectMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select how you are feeling')),
      );
      return;
    }
    if (contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something before saving')),
      );
      return;
    }

    if (isEditing) {
      final updatedEntry = JournalEntry(
        id: widget.entry!.id,
        mood: selectMood!,
        title: titleController.text.trim().isEmpty
            ? null
            : titleController.text.trim(),
        content: contentController.text.trim(),
        dateTime: selectedDate,
        userId: currentUserNotifier.value!.id,
      );
      await updateJournalById(widget.entry!.id, updatedEntry);

      if (!mounted) return;

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Journal updated successfully')),
      );
      return;
    }

    final newEntry = JournalEntry(
      id: Uuid().v4(),
      mood: selectMood!,
      title: titleController.text.trim().isEmpty
          ? null
          : titleController.text.trim(),
      content: contentController.text.trim(),
      dateTime: selectedDate,
      imagePath: selectedImage?.path,
      userId: currentUserNotifier.value!.id,
    );

    await addJournal(newEntry);
    titleController.clear();
    contentController.clear();
    setState(() {
      selectMood = null;
      selectedDate = DateTime.now();
    });
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Journal saved successfully')));
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text(
          isEditing ? 'Edit Journal' : 'New Journal',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(18),
          children: [
            SizedBox(height: 10),

            DatePickerCard(selectedDate: selectedDate, onTap: _pickDate),

            const SizedBox(height: 20),

            MoodSelector(
              selectedMood: selectMood,
              onMoodSelected: (mood) {
                setState(() {
                  selectMood = mood;
                });
              },
            ),

            SizedBox(height: 20),

            JournalForm(
              titleController: titleController,
              contentController: contentController,
              onAddPhoto: () {
                pickImage();
              },
            ),
            SizedBox(height: 30),

            SaveJournalButton(isEditing: isEditing, onPressed: saveJournal),
          ],
        ),
      ),
    );
  }
}
