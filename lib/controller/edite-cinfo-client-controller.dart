import 'dart:io';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/function/image-picker.dart';
import 'package:ccount/core/function/snackBar-massage-fun.dart';
import 'package:ccount/core/function/validetor.dart';
import 'package:ccount/core/services/service.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:ccount/data/model/user-model.dart';
import 'package:ccount/data/repository/customer-repo.dart';
import 'package:ccount/view/debt/client/view/page-client-transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class EditInfoClientController extends GetxController {
  CustomerModel? client;
  // CustomerModel? data;
  CustomerRepository clientREpo = Get.find();
  Services shPref = Get.find();
  GlobalKey<FormState> formKeyEditClient = GlobalKey<FormState>();
  TextEditingController nameClientController = TextEditingController();
  TextEditingController locationClientController = TextEditingController();
  TextEditingController phoneClientController = TextEditingController();
  // @override
  // void onClose() {
  //   super.onClose();
  //   nameClientController.dispose();
  //   locationClientController.dispose();
  //   phoneClientController.dispose();
  // }

  File? fileProfileImageClient;
  String? pathImageClient;
  Widget? errorIcon;

  bool isChanged = false;
  getPicker(BuildContext context) async {
    final XFile? image = await showImageSourceBottomSheet(context);
    if (image != null) {
      pathImageClient = image.path;
      fileProfileImageClient = File(image.path);
      isChanged = true;

      update();
    }
  }

  setErrorIcon() {
    errorIcon = Icon(
      Iconsax.info_circle,
      color: AppColor.error,
    );
    update();
  }

  setErrorIconTrue() {
    errorIcon = null;

    update();
  }

  changeT() {
    isChanged = true;
    update();
  }

  changeF() {
    isChanged = false;
    update();
  }

  formValidateUpdated(BuildContext context) async {
    var fKey = formKeyEditClient.currentState;

    if (fKey!.validate() &&
        nameClientController.text.toString().trim().isNotEmpty) {
      // shPref.sharedPreferences.setBool("isLoggedIn", true);
      client = CustomerModel(
        id: client!.id,
        name: nameClientController.text.toString().trim(),
        address: locationClientController.text,
        phone: phoneClientController.text,
        pathImageProfile: pathImageClient,
        currncy: client!.currncy,
        customerTypeId: client!.customerTypeId,
        date: client!.date,
        // time: client!.time,

        groupId: client!.groupId,
        notes: client!.notes,
        numberTrans: client!.numberTrans,
        lakom: client!.lakom,
        alikom: client!.alikom,
      );
      clientREpo.updateCustomer(client!);

      isChanged = false;
      showSnakBarMassageSecc(context, "تم التعديل");
      goToTransactionClient();
      // Get.offAllNamed(AppPage.homePage);
    } else {
      setErrorIcon();
    }
    update();
  }

  goToTransactionClient() {
    Get.off(() => PageClientTransaction(),
        arguments: client!.id!, transition: Transition.leftToRight);
  }

  @override
  void onInit() {
    super.onInit();
    client = Get.arguments;
    nameClientController.text = client!.name!;
    locationClientController.text = client!.address!;
    phoneClientController.text = client!.phone!;

    pathImageClient = client!.pathImageProfile;
    if (pathImageClient != AppImage.userProfile) {
      fileProfileImageClient = File(pathImageClient!);
    }
  }
}
