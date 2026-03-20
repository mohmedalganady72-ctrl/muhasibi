import 'package:ccount/core/constant/app-color.dart';
import 'package:flutter/material.dart';

class MatrialAppBar extends StatelessWidget {
  const MatrialAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundPage,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.backgroundIcon, width: 1),
          // backgroundBlendMode: BlendMode.darken,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColor.Selected,
            //  const Color.fromARGB(55, 229, 241, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: AppColor.iNoSelected,
          padding: const EdgeInsets.all(3),
          dividerColor: Colors.transparent,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          tabs: const [
            Tab(text: "Local"),
            Tab(text: "SAR"),
            Tab(text: "YER"),
            Tab(text: "USD"),
          ],
        ),
      ),
    );
  }
}
