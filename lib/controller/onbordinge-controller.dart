import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/services/service.dart';
import 'package:ccount/data/data-source/static.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class OnbordingeController extends GetxController {
  nextPage();
  skipPage();
  onChangePage(int index);
}

class OnbordingeControllerPage extends OnbordingeController {
  Services sevice = Get.find();
  int courrentPage = 0;
  get getCourrentPage => courrentPage;
  late PageController pageController;

  @override
  nextPage() {
    if (courrentPage == onbordingeStatic.length - 1) {
      sevice.sharedPreferences.setBool("onBordinge", true);
      Get.offAllNamed(AppPage.userProfilePage);
    } else {
      courrentPage++;
      pageController.animateToPage(courrentPage,
          duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
    update();
  }

  @override
  skipPage() {
    Get.offAllNamed(AppPage.userProfilePage);
    sevice.sharedPreferences.setBool("onBordinge", true);
    update();
  }

  @override
  onChangePage(int index) {
    courrentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
