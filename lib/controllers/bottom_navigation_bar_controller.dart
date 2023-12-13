import 'package:get/get.dart';

class NavBarIndexController extends GetxController {
  int _selectedIndex = 0;
  int get getSelectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
