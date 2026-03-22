import 'package:ccount/core/theme/theme_mode/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeTheme controller = Get.find<ChangeTheme>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('More Screen'),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () => controller.toggleTheme(),
              child: Icon(
                controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          )
          // _buildThemeOption(
          //   context,
          //   themeController,
          //   'light',
          //   'فاتح',
          //   Icons.light_mode,
          //   Colors.amber,
          // ),
        ],
      ),
      body: const Center(
        child: Text('More Screen Content'),
      ),
    );
  }
}
