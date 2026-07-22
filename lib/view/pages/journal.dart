import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/models/journal_model.dart';
import 'package:pebble_project/view/widgets/journal_cards.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  static const List<String> tabs = ['All', 'Happy', 'Calm', 'Sad', 'Angry'];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    getAllJournal();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime dt) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'pm' : 'am';
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}  $hour12.$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          toolbarHeight: 70,
          title: const Text('My Journal', style: TextStyle(fontSize: 30)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Journals...',
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: Color.fromARGB(255, 129, 129, 129),
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 129, 129, 129),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 254, 235, 163),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    unselectedLabelColor: Colors.black54,
                    dividerColor: Colors.transparent,
                    tabs: tabs.map((label) => Tab(text: label)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ValueListenableBuilder<List<JournalEntry>>(
          valueListenable: journalNotifier,
          builder: (context, allEntries, _) {
            final sorted = [...allEntries]
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

            final searched = _searchQuery.isEmpty
                ? sorted
                : sorted.where((e) {
                    final title = (e.title ?? '').toLowerCase();
                    final content = (e.content).toLowerCase();
                    final mood = (e.mood).toLowerCase();
                    return title.contains(_searchQuery) ||
                        content.contains(_searchQuery) ||
                        mood.contains(_searchQuery);
                  }).toList();

            return TabBarView(
              children: tabs.map((mood) {
                final entries = mood == 'All'
                    ? searched
                    : searched.where((e) => e.mood == mood).toList();

                if (entries.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isNotEmpty
                          ? 'No results for "$_searchQuery"'
                          : 'No $mood journals yet',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];

                    return JournalCard(
                      entry: entry,
                      dateLabel: _formatDate(entry.dateTime),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
