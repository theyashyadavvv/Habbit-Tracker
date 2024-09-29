import 'package:flutter/material.dart';
import 'package:habbit_app/Screen/login/SignInScreen.dart';
import 'package:habbit_app/Screen/login/signup_screen.dart';
import 'package:habbit_app/color_glonbal_onboard/color.dart';
import 'package:habbit_app/color_glonbal_onboard/golobal.dart';
import 'package:habbit_app/color_glonbal_onboard/onboard.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class Welcome_screen extends StatefulWidget {
  const Welcome_screen({super.key});

  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

// ignore: camel_case_types
class _Welcome_screenState extends State<Welcome_screen> {
  @override
  Widget build(BuildContext context) {
    final c = PageController();
    final list = [
      Onboard(
          title: "Calender",
          subtitle:
              "Organize, manage tasks, schedule appointments quickly and easily",
          lottie: 'welcome'),
      Onboard(
          title: 'To-Do',
          subtitle: 'Help you manage your work more convenient',
          lottie: 'TODO'),
      Onboard(
          title: 'Reminder',
          subtitle:
              'Be notified, reminded, no, need to waste time remembering work.',
          lottie: 'reminder'),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              hexStringToColor("CB2B93"), // Your custom colors
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
          ),
        ),
        child: PageView.builder(
          controller: c,
          itemCount: list.length,
          itemBuilder: (ctx, ind) {
            return Column(
              children: [
                Lottie.asset(
                  'assets/lottie/${list[ind].lottie}.json',
                  height: Mq.height * .7,
                  width: ind == list.length - 1 ? Mq.width * .9 : null,
                ),

                // Title
                Text(
                  list[ind].title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .5),
                ),

                const SizedBox(height: 10), // Spacing
                SizedBox(
                  width: Mq.width * .7,
                  child: Text(
                    list[ind].subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .5,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: Mq.width * .4),
                const Spacer(),

                // Dots indicator
                Wrap(
                  spacing: 10,
                  children: List.generate(
                    list.length,
                    (i) => Container(
                      width: i == ind ? 15 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == ind ? Colors.black : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9)),
                      ),
                    ),
                  ),
                ),
                const Spacer(),

                // Next or Finish button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    minimumSize: Size(Mq.width * .3, 40),
                  ),
                  onPressed: () {
                    if (ind == list.length - 1) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const SignUpScreen()));
                    } else {
                      c.nextPage(
                        duration: const Duration(microseconds: 600),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    ind == list.length - 1 ? 'Finish' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          },
        ),
      ),
    );
  }
}
