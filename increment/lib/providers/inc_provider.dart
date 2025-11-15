import 'package:flutter/material.dart';

class IncProvider extends ChangeNotifier {
  int value;
  IncProvider({this.value = 0});

  void incrementCounter() {
    value++;
    notifyListeners();
  }

  void decrementCounter() {
    value--;
    notifyListeners();
  }
}
