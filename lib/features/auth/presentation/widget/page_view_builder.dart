import 'package:ccount/features/auth/presentation/controllers/onbordinge_controller.dart';
import 'package:ccount/features/auth/data/datasources/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PageViewBuilder extends GetView<OnbordingeControllerPage> {
  const PageViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnbordingeControllerPage());
    return PageView.builder(
        controller: controller.pageController,
        onPageChanged: (value) => controller.onChangePage(value),
        scrollDirection: Axis.horizontal,
        itemCount: onbordingeStatic.length,
        itemBuilder: ((context, pageIndex) => Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
            child: ListView(
              shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  onbordingeStatic[pageIndex].image,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                    textAlign: TextAlign.center,
                    onbordingeStatic[pageIndex].title),
                SizedBox(
                  height: 30.h,
                ),
                Text(onbordingeStatic[pageIndex].body,
                    textAlign: TextAlign.center),
              ],
            ))));
  }
}

