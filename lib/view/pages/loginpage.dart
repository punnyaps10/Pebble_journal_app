import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pebble_project/core/constants/app_color.dart';
import 'package:pebble_project/core/services/user_service.dart';
import 'package:pebble_project/view/pages/navbar.dart';
import 'package:pebble_project/view/pages/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }
    final success = await loginUser(email, password);
    if (!mounted) return;
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Navbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 240),
      body: Column(
        children: [
          const SizedBox(height: 100),

          Center(
            child: Text(
              'Pebble',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'Track your mood, build better habits \n   habits and cherish your everyday.',
            ),
          ),
          SizedBox(height: 40),

          Container(
            height: 400,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'LOGIN HERE',
                    style: GoogleFonts.kanchenjunga(
                      color: Color(0xFFF7C500),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: 270,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      labelText: 'Enter your Email',
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      filled: true,
                      fillColor: AppColor.containerColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                SizedBox(
                  width: 270,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      labelText: 'Enter your Password',
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      filled: true,
                      fillColor: AppColor.containerColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                SizedBox(
                  width: 270,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
