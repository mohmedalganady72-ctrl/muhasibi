import 'package:ccount/core/services/service.dart';
import 'package:ccount/data/model/dbModel/currency-model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChangeLanguage extends GetxController {
  Services shardprefrance = Get.find();
  Locale? language;

  loacllang(String languageCode) {
    Locale locale = Locale(languageCode);

    shardprefrance.sharedPreferences.setString("lang", languageCode);

    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? shardpreLange = shardprefrance.sharedPreferences.getString("lang");
    String? currncyCode =
        shardprefrance.sharedPreferences.getString("currncyCode");
    if (shardpreLange == "ar") {
      language = const Locale("ar");

      Get.updateLocale(language!);
    } else if (shardpreLange == "en") {
      language = const Locale("en");

      Get.updateLocale(language!);
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      shardprefrance.sharedPreferences
          .setString("lang", language!.languageCode);

      Get.updateLocale(language!);
    }
    // if (currncyCode == null) {
    //   CurrencyModel currencyMo = CurrencyModel(name: "YEMEN", code: "YER");

    //   shardprefrance.sharedPreferences.setString("currncyCode", "YER");
    // }

    super.onInit();
  }
}
