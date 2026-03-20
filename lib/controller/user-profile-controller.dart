import 'dart:io';

import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/function/image-picker.dart';
import 'package:ccount/core/function/validetor.dart';
import 'package:ccount/core/services/service.dart';
import 'package:ccount/data/model/user-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  Services shPref = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    locationController.dispose();
    phoneController.dispose();
  }

  File? profileImage;

  getPicker(BuildContext context) async {
    final XFile? image = await showImageSourceBottomSheet(context);
    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  formValidate() {
    var fKey = formKey.currentState;

    if (fKey!.validate()) {
      shPref.sharedPreferences.setBool("isLoggedIn", true);
      UserModel(
        name: nameController.text,
        location: locationController.text,
        phone: phoneController.text,
      );
      Get.offAllNamed(AppPage.homePage);
    }
  }
}
