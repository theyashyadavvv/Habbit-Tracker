import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:habbit_app/Screen/login/SignInScreen.dart';
import 'package:habbit_app/pages/NavigationScreen.dart';
import 'package:habbit_app/color_glonbal_onboard/color.dart';
import 'package:habbit_app/main.dart';
import 'package:habbit_app/reusable_widgets/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();

  Future<void> addUserDetails(String uid, String name, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            const Image(
                              image: AssetImage(
                                'assets/images/login.png',
                              ),
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                reusableTextField(
                                  "Enter Name",
                                  Icons.person_outline_rounded,
                                  false,
                                  _firstNameTextController,
                                ),
                                const SizedBox(height: 20),
                                reusableTextField(
                                  "Enter Email Id",
                                  Icons.email_rounded,
                                  false,
                                  _emailTextController,
                                ),
                                const SizedBox(height: 20),
                                reusableTextField(
                                  "Enter Password",
                                  Icons.lock_outlined,
                                  true,
                                  _passwordTextController,
                                ),
                                const SizedBox(height: 20),
                                firebaseUIButton(context, "Sign Up", () async {
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email:
                                                    _emailTextController.text,
                                                password:
                                                    _passwordTextController
                                                        .text);

                                    User? user = userCredential.user;

                                    if (user != null) {
                                      await addUserDetails(
                                        user.uid,
                                        _firstNameTextController.text.trim(),
                                        _emailTextController.text.trim(),
                                      );

                                      print("Created New Account");

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavigationScreen()));
                                    }
                                  } catch (error) {
                                    print("Error ${error.toString()}");
                                  }
                                }),
                                const SizedBox(height: 20),
                                const Text("OR"),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Image(
                              image: AssetImage('assets/images/google.png'),
                              width: 20.0,
                            ),
                            label: const Text(
                              "Sign-In With Google",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Color.fromARGB(240, 0, 0, 0)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                );
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
}
