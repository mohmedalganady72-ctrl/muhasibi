import 'package:ccount/app/bindings/app_binding.dart';
import 'package:ccount/core/localization/change_language.dart';
import 'package:ccount/core/localization/translation.dart';
import 'package:ccount/core/theme/theme_mode/change_theme.dart';
import 'package:ccount/core/theme/theme_mode/dark_them.dart';
import 'package:ccount/core/theme/theme_mode/ligth_them.dart';
import 'package:ccount/test/table_tast.dart';

import 'package:ccount/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeLanguage chLanController = Get.put(ChangeLanguage());
    ChangeTheme chThemeController = Get.put(ChangeTheme());

    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            showSemanticsDebugger: false,
            theme: lightTheme,
            initialBinding: BindingApp(),
            darkTheme: darkTheme,
            themeMode: chThemeController.themeMode.value,
            home: const Home(),
            translations: Translation(),
            locale: chLanController.language,
          );
        });
  }
}

