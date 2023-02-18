import 'package:flutter/material.dart';

class TabManager extends ChangeNotifier {
  // initializing and assigning value to _selectedIndex
  int selectedIndex = 0;

  // updating the tab
  void goToTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
