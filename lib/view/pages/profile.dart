import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/view/pages/loginpage.dart';
import 'package:pebble_project/view/widgets/profile_about.dart';
import 'package:pebble_project/view/widgets/profile_help.dart';
import 'package:pebble_project/view/widgets/profile_privacy.dart';
import 'package:pebble_project/view/widgets/profile_settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    await updateProfileImage(picked.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: currentUserNotifier,
          builder: (context, value, child) {
            final imagePath = value?.profileImagePath;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: (imagePath != null)
                            ? FileImage(File(imagePath)) as ImageProvider
                            : const AssetImage("assets/default_avatar.png"),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Text(
                      value?.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      value?.email ?? 'No Email',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade200,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          _pickImageFromGallery();
                        },
                        child: const Text("Edit Profile"),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SettingsTile(
                      title: "Help",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpPage()),
                        );
                      },
                    ),
                    SettingsTile(
                      title: "Privacy Center",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyCenterPage(),
                          ),
                        );
                      },
                    ),
                    SettingsTile(
                      title: "About",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          logoutUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
