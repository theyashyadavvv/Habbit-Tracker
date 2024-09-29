import 'package:flutter/material.dart';
import 'package:habbit_app/color_glonbal_onboard/color.dart'; // Import your color file

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hexStringToColor("CB2B93"), // Custom gradient colors
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Transparent background to allow the gradient
        appBar: AppBar(
          title: Text("About This App"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Habit Tracker",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Habit Tracker is an application designed to help you build and maintain healthy habits. The app allows you to track your daily habits, set goals, and monitor your progress over time.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Version: 1.0.0",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Developed by: Yash",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
