import 'package:flutter/material.dart';
import 'package:habbit_app/Screen/login/welcome_screen.dart';
import 'dart:async';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'package:habbit_app/color_glonbal_onboard/golobal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Home Screen after 3 seconds
    // milliseconds: 4200
    Timer(const Duration(milliseconds: 4200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const Welcome_screen(), // Replace with your actual home screen widget
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(255, 3, 77, 63), // Peach
              // Color.fromARGB(255, 4, 55, 6),
              Color.fromARGB(255, 95, 4, 101),
              Color.fromARGB(255, 4, 14, 80), // Peach
              // Peach
              // Soft Blue
            ],
          ),
        ), // Background color
        child: Center(
          child: Lottie.asset(
            'assets/lottie/logo.json', // Path to the Lottie animation file
            width: Mq.width * .6, // Size of the Lottie animation
          ),
        ),
      ),
    );
  }
}
