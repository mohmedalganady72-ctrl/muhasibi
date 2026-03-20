import 'package:ccount/core/services/service.dart';
import 'package:ccount/core/theme/themeMode/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ChangeTheme extends GetxController {
//   Services shPreFrance = Get.find();

//   ThemeData? themeData;

//   changeTheme(String theme) {
//     if (theme == "dark") {
//       themeData = ThemeData.dark();
//     } else {
//       themeData = ThemeData.light();
//     }

//     shPreFrance.sharedPreferences.setString("theme", theme);
//     Get.changeTheme(themeData!);
//     update();
//   }

//   @override
//   void onInit() {
//     String? themedata = shPreFrance.sharedPreferences.getString("theme");

//     if (themedata == "dark") {
//       themeData = ThemeData.dark();
//       Get.changeTheme(themeData!);
//     } else if (themedata == "light") {
//       themeData = ThemeData.light();
//       Get.changeTheme(themeData!);
//     } else {
//       // get them system
//       themeData = ThemeData.fallback();
//       shPreFrance.sharedPreferences.setString("theme", "system");
//       Get.changeTheme(themeData!);
//     }

//     super.onInit();
//   }
// }

class ChangeTheme extends GetxController {
  final Services sharedPrefService = Get.find();

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString currentThemeName = 'system'.obs;

  // Available themes
  static final Map<String, ThemeData> availableThemes = {
    'light': AppTheme.light,
    'dark': AppTheme.dark,
  };

  ThemeData get currentLight => AppTheme.light;
  ThemeData get currentDark => AppTheme.dark;

  /// Get current theme based on mode and system preference
  ThemeData get currentTheme {
    if (themeMode.value == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? currentDark : currentLight;
    } else if (themeMode.value == ThemeMode.dark) {
      return currentDark;
    } else {
      return currentLight;
    }
  }

  /// Get theme by name
  ThemeData? getThemeByName(String themeName) {
    return availableThemes[themeName];
  }

  /// Get all available theme names
  List<String> get availableThemeNames => availableThemes.keys.toList();

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    final String key = mode == ThemeMode.dark
        ? 'dark'
        : mode == ThemeMode.light
            ? 'light'
            : 'system';
    currentThemeName.value = key;
    sharedPrefService.sharedPreferences.setString('theme', key);
    update();
  }

  /// Change theme by name (for custom themes)
  void changeThemeByName(String themeName) {
    if (availableThemes.containsKey(themeName)) {
      currentThemeName.value = themeName;
      sharedPrefService.sharedPreferences.setString('theme', themeName);

      // Map theme name to ThemeMode
      if (themeName == 'dark') {
        themeMode.value = ThemeMode.dark;
      } else if (themeName == 'light') {
        themeMode.value = ThemeMode.light;
      } else {
        // For custom themes, we'll use light mode as base
        themeMode.value = ThemeMode.light;
      }
      update();
    }
  }

  @override
  void onInit() {
    final String? stored =
        sharedPrefService.sharedPreferences.getString('theme');
    if (stored != null && availableThemes.containsKey(stored)) {
      currentThemeName.value = stored;
      if (stored == 'dark') {
        themeMode.value = ThemeMode.dark;
      } else if (stored == 'light') {
        themeMode.value = ThemeMode.light;
      } else if (stored == 'system') {
        themeMode.value = ThemeMode.system;
      } else {
        // Custom theme - use light mode as base
        themeMode.value = ThemeMode.light;
      }
    } else {
      themeMode.value = ThemeMode.light;
      currentThemeName.value = 'system';
      sharedPrefService.sharedPreferences.setString('theme', 'system');
      // }
      super.onInit();
    }
    ;
  }

  /// Check if current theme is dark
  bool get isDarkMode {
    if (themeMode.value == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }

  /// Toggle between light and dark themes
  void toggleTheme() {
    if (isDarkMode) {
      changeThemeMode(ThemeMode.light);
    } else {
      changeThemeMode(ThemeMode.dark);
    }
    update();
  }
}
