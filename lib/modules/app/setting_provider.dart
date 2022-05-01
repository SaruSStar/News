import 'package:flutter/foundation.dart';

class SettingProvider with ChangeNotifier {
  int _navigationBarIndex = 0;
  // Floating bottom bar index which is located in DashboardView
  int get navigationBarIndex => _navigationBarIndex;

  void changeBottomNavigationBarIndex(int index) {
    _navigationBarIndex = index;
    notifyListeners();
  }
}
