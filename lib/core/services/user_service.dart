import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pebble_project/core/services/journal_service.dart';
import 'package:pebble_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<UserModel?> currentUserNotifier = ValueNotifier(null);

Future<bool> signUpUser(UserModel newUser) async {
  final userBox = Hive.box<UserModel>('users');

  final alreadyExists = userBox.values.any((u) => u.email == newUser.email);
  if (alreadyExists) return false;

  await userBox.add(newUser);
  currentUserNotifier.value = newUser;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userEmail', newUser.email);
  return true;
}

Future<bool> loginUser(String email, String password) async {
  final userBox = Hive.box<UserModel>('users');

  final matches = userBox.values.where(
    (u) => u.email == email && u.password == password,
  );
  if (matches.isEmpty) return false;

  currentUserNotifier.value = matches.first;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userEmail', matches.first.email);
  return true;
}

Future<void> loadCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();

  final email = prefs.getString('userEmail');

  if (email == null) return;

  final userBox = Hive.box<UserModel>('users');

  try {
    final user = userBox.values.firstWhere((u) => u.email == email);

    currentUserNotifier.value = user;
  } catch (_) {}
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();

  final loggedIn = prefs.getBool('isLoggedIn') ?? false;

  if (loggedIn) {
    await loadCurrentUser();
  }

  return loggedIn;
}

Future<void> logoutUser() async {
  currentUserNotifier.value = null;
  journalNotifier.value = [];

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isLoggedIn", false);
  await prefs.remove("userEmail");
}

Future<void> updateProfileImage(String imagePath) async {
  final current = currentUserNotifier.value;
  if (current == null) return;

  final userBox = Hive.box<UserModel>('users');

  final key = userBox.keys.firstWhere(
    (k) => userBox.get(k)?.id == current.id,
    orElse: () => null,
  );
  if (key == null) return;
  current.profileImagePath = imagePath;

  await userBox.put(key, current);
  currentUserNotifier.value = current;
}
