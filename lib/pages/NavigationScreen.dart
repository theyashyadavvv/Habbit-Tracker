import 'package:flutter/material.dart';
import 'package:habbit_app/pages/habitPgea.dart';
import 'package:habbit_app/pages/homePage.dart';
import 'package:habbit_app/pages/profilePage.dart';
import 'package:habbit_app/pages/progressPage.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key}); // Changed to const for consistency

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0; // Moved currentIndex to state

  // Added all screens to the list to match the BottomNavigationBar items
  final List<Widget> _screens = [
    const HomePage(),
    const habitsPage(),
    const ProgressPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
