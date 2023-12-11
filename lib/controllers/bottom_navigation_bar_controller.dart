import 'package:get/get.dart';

class NavBarIndexController extends GetxController {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void getSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
