import 'package:ccount/controller/client-controller.dart';
import 'package:ccount/core/constant/app-color.dart';

import 'package:ccount/core/constant/databaseTable/all-name-use-quary.dart';

import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:ccount/data/model/dbModel/box-model.dart';
import 'package:ccount/data/repository/currency-repo.dart';
import 'package:ccount/data/repository/box-repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CurrncyController extends GetxController {
  // ClientController ddf = Get.find<ClientController>();

  final GlobalKey<FormState> currncyFormKey = GlobalKey<FormState>();
  TextEditingController codeCurrncyController = TextEditingController();
  TextEditingController nameCurrncyController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    codeCurrncyController.dispose();
    nameCurrncyController.dispose();
  }

  late CurrencyModel cModel;
  late BoxModel bModel;
  CurrencyRepository currncyRep = Get.find();
  BoxRepository boxRep = Get.find();
  List<CurrencyModel> codes = [];
  bool isDataView = false;
  Widget? errorIconName;
  Widget? errorIconCode;

  setIconErrorName() {
    errorIconName = Icon(
      Iconsax.info_circle,
      color: AppColor.error,
    );
    update();
  }

  setIconErrorTrueName() {
    errorIconName = null;
    update();
  }

  setIconErrorCode() {
    errorIconCode = Icon(
      Iconsax.info_circle,
      color: AppColor.error,
    );
    update();
  }

  setIconErrorTrueCode() {
    errorIconCode = null;
    update();
  }

  addNewCurrncyClinet() async {
    if (currncyFormKey.currentState!.validate() &&
        (nameCurrncyController.text.toString().trim().isNotEmpty &&
            codeCurrncyController.text.toString().trim().isNotEmpty)) {
      cModel = CurrencyModel(
          name: nameCurrncyController.text.toString().trim(),
          code: codeCurrncyController.text.toString().trim(),
          customerType: "client");

      await currncyRep.addCurrency(cModel);
      bModel = BoxModel(
          BTCustomer: "client",
          alihe: 0,
          currncyCode: codeCurrncyController.text,
          laho: 0);
      await boxRep.insertBox(bModel);
      codes.add(cModel);

      nameCurrncyController.clear();
      codeCurrncyController.clear();
      errorIconName = null;
      errorIconCode = null;
    } else {
      if (nameCurrncyController.text.toString().trim().isEmpty) {
        errorIconName = Icon(
          Iconsax.info_circle,
          color: AppColor.error,
        );
      }
      if (codeCurrncyController.text.toString().trim().isEmpty) {
        errorIconCode = Icon(
          Iconsax.info_circle,
          color: AppColor.error,
        );
      }
    }
    update();
  }

  clearController() {
    nameCurrncyController.clear();
    codeCurrncyController.clear();
  }

  getCurrncyModelToList() async {
    codes = await currncyRep.getAllCurrenciesCustomerType("client");
    isDataView = true;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCurrncyModelToList();
  }
}
