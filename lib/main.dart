import 'package:ccount/app/app.dart';
import 'package:ccount/core/services/service.dart';
import 'package:ccount/core/theme/theme_mode/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await inislizetion();
  Get.put(ChangeTheme());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const Account());
}
