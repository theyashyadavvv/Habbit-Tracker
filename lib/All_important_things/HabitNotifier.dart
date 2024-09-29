import 'package:flutter/material.dart';

class HabitNotifier extends ChangeNotifier {
  List<List<dynamic>> _habitList = [];

  List<List<dynamic>> get habitList => _habitList;

  void setHabits(List<List<dynamic>> newHabits) {
    _habitList = newHabits;
    notifyListeners();
  }

  void addHabit(List<dynamic> habit) {
    _habitList.add(habit);
    notifyListeners();
  }

  void deleteHabit(int index) {
    _habitList.removeAt(index);
    notifyListeners();
  }
}
