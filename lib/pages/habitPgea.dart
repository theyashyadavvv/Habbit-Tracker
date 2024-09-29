import 'package:flutter/material.dart';
import 'package:habbit_app/All_important_things/chartsBuilder.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Image.asset('assets/images/HabitsPageBackground.png'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 140, 0, 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Your Habits",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Use this to be inspired",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Limit list view height
              child: ListView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 200,
                    child: LineChartSample1(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: LineChartSample2(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: LineChartSample3(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
