import 'package:get/get.dart';

class HomeController extends GetxController {
  int _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  changeIndex(int index) {
    _selectedIndex = index;

    update();
  }
}
