import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habbit_app/pages/AccountInfoPage.dart';
import 'package:habbit_app/pages/about_app_page.dart';
import 'package:habbit_app/pages/homePage.dart';
import 'package:habbit_app/All_important_things/database_helper.dart';
import 'package:habbit_app/Screen/login/SignInScreen.dart';
import 'package:habbit_app/color_glonbal_onboard/color.dart'; // Import your color file

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? userName; // To store the user's name
  File? _profileImage; // To store the profile image
  final String _profileImageKey =
      'profileImagePath'; // Key for storing profile image path

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Fetch the user's name
    _loadProfileImage(); // Load the profile image from SharedPreferences
  }

  // Fetch the username from the database
  Future<void> _fetchUserName() async {
    final name = await _dbHelper
        .getCurrentUserEmail(); // Assuming you store the email or name
    setState(() {
      userName = name;
    });
  }

  // Pick an image from the gallery and store its path
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _saveProfileImagePath(pickedFile.path); // Save the image path
      });
    }
  }

  // Save the image path in SharedPreferences
  Future<void> _saveProfileImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  // Load the profile image path from SharedPreferences
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(_profileImageKey);
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  // Remove the profile image
  Future<void> _removeProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileImageKey);
    setState(() {
      _profileImage = null;
    });
  }

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
            Colors.transparent, // Transparent background for gradient
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 20),
          children: [
            GestureDetector(
              onTap: _pickImage, // Change profile image when tapped
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.purpleAccent,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) // Display picked image
                    : const NetworkImage(
                            'https://cdn2.iconfinder.com/data/icons/avatars-60/5985/12-Delivery_Man-512.png')
                        as ImageProvider, // Fallback avatar
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                userName != null ? "Hey $userName!" : "Hey there!",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "What a wonderful day!!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Divider(),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("My Account Info"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInfoPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text("My Subscription Info"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("My all Habits"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About This App"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppPage()),
                );
              },
            ),
            const Divider(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false, // Remove all previous routes
                  );
                },
                child: const Text(
                  "Log Out",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _removeProfileImage, // Remove the profile picture
              child: const Text("Remove Profile Picture"),
            )
          ],
        ),
      ),
    );
  }
}
