import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:habbit_app/All_important_things/database_helper.dart';
import 'package:habbit_app/color_glonbal_onboard/golobal.dart'; // Adjust import path as needed
import 'package:habbit_app/All_important_things/lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  int counter = 0;
  String? userName; // To store the fetched user name

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Fetch the user's name from Firestore
  }

  // Fetch the logged-in user's name from Firestore
  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      String uid = user.uid; // Get the user's UID

      try {
        // Fetch the user's document from Firestore using the UID
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        // Extract the user's name from the document
        setState(() {
          userName = userDoc.get('name'); // Assuming the field is 'name'
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  Future<void> _deleteHabit(int index) async {
    final habitId = habitList[index][4] as int; // Assuming habitList has IDs
    await _dbHelper.deleteHabit(habitId); // Delete habit from the database
    setState(() {
      habitList.removeAt(index);
      _updateCounter(); // Update the counter after deletion
    });
  }

  void _updateCounter() {
    counter = habitList.where((habit) => habit[0] as bool).length;
  }

  void addToHabitList(String habitName, String habitDescription) async {
    // Add habit to the local list
    final habitId = await _dbHelper.database.then((db) async {
      final result =
          await db.insert('habits', {'name': habitName, 'progress': 0.0});
      return result;
    });

    habitList
        .add([false, habitName, habitDescription, Icon(Icons.abc), habitId]);

    setState(() {}); // Refresh UI
  }

  void addHabit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController habitNameController =
            TextEditingController(text: "Habit Name");
        TextEditingController habitDescriptionController =
            TextEditingController(text: "Habit Description");

        return AlertDialog(
          title: Text("Add a Habit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: habitNameController,
                decoration: InputDecoration(hintText: 'Habit Name'),
              ),
              TextFormField(
                controller: habitDescriptionController,
                decoration: InputDecoration(hintText: 'Habit Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                surfaceTintColor:
                    MaterialStateProperty.all(Colors.purpleAccent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                surfaceTintColor:
                    MaterialStateProperty.all(Colors.purpleAccent),
              ),
              onPressed: () {
                setState(() {
                  addToHabitList(habitNameController.text,
                      habitDescriptionController.text);
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          addHabit(context);
        },
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(padding: EdgeInsets.zero, children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Image.asset('assets/images/MainBackground.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Text(
                      userName != null ? "Hey $userName!" : "Hey there!",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "You have ${habitList.length - counter} habits left for today",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
        Container(
          width: Mq.width, // Assuming Mq is a helper for screen dimensions
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Keep Going!",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      Text("${((counter / habitList.length) * 100).round()}%",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16))
                    ],
                  ),
                ),
                SizedBox(
                  width: Mq.width * 0.85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      color: Colors.deepPurpleAccent,
                      backgroundColor: Color.fromARGB(255, 192, 170, 250),
                      value: (habitList.length > 0)
                          ? (counter / habitList.length)
                          : 0.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(),
                ),
                SizedBox(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: habitList.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                          title: Text(habitList[index][1]),
                          subtitle: Text(habitList[index][2]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteHabit(index),
                              ),
                              habitList[index][3],
                            ],
                          ),
                          leading: Checkbox(
                            value: habitList[index][0],
                            onChanged: (value) {
                              setState(() {
                                if (value == false) {
                                  counter -= 1;
                                  habitList[index][0] = value;
                                } else {
                                  counter += 1;
                                  habitList[index][0] = value;
                                }
                                _updateCounter(); // Update the counter
                              });
                            },
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
