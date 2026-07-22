import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/view/widgets/home_quotes_data.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/view/widgets/home_mood_display.dart';
import 'package:pebble_project/view/widgets/home_moodcard.dart';
import 'package:pebble_project/view/widgets/home_quotebox.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime today = DateTime.now();

  String selectedMood = 'Happy';
  late String currentQuote;

  @override
  void initState() {
    super.initState();
    currentQuote = QuotesData.getRandomQuote(selectedMood);
  }

  void _onMoodSelected(String mood) {
    setState(() {
      selectedMood = mood;
      currentQuote = QuotesData.getRandomQuote(mood);
    });
  }

  void _onRefresh() {
    setState(() {
      currentQuote = QuotesData.getRandomQuote(
        selectedMood,
        excluding: currentQuote,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        toolbarHeight: 80,
        title: ValueListenableBuilder(
          valueListenable: currentUserNotifier,
          builder: (context, user, _) {
            return Text(
              'Hi, ${user?.name ?? 'Guest'}',
              style: const TextStyle(fontSize: 34),
            );
          },
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ValueListenableBuilder(
              valueListenable: currentUserNotifier,
              builder: (context, user, _) {
                final imagePath = user?.profileImagePath;
                return CircleAvatar(
                  radius: 30,
                  backgroundImage: (imagePath != null)
                      ? FileImage(File(imagePath)) as ImageProvider
                      : const AssetImage("assets/default_avatar.png"),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          TableCalendar(
            focusedDay: today,
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            calendarFormat: CalendarFormat.week,
            headerVisible: false,
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                color: AppColor.containerColor,
                shape: BoxShape.circle,
              ),
              weekendDecoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          const SizedBox(height: 20),
          
          MoodDisplay(mood: selectedMood),

          Moodcard(selectedMood: selectedMood, onMoodSelected: _onMoodSelected),
          const SizedBox(height: 20),
          Quotes(currentQuote: currentQuote, onRefresh: _onRefresh),
        ],
      ),
    );
  }
}
