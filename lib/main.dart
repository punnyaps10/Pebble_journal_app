import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/models/journal_model.dart';
import 'package:pebble_project/models/user_model.dart';
import 'package:pebble_project/view/pages/navbar.dart';
import 'package:pebble_project/view/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(UserModelAdapter());

  // 1. ആദ്യം പഴയ ബോക്സ് ഡിസ്കിൽ നിന്ന് ഡിലീറ്റ് ചെയ്യുക
  await Hive.deleteBoxFromDisk('journals');

  // 2. അതിനുശേഷം മാത്രം ബോക്സുകൾ ഓപ്പൺ ചെയ്യുക
  await Hive.openBox<JournalEntry>('journals');
  await Hive.openBox<UserModel>('users');

  await getAllJournal();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.kanchenjungaTextTheme()),
      home: FutureBuilder(
        future: isUserLoggedIn(),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshort.data == true) {
            return Navbar();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
