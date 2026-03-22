import 'package:ccount/features/auth/presentation/controllers/onbordinge_controller.dart';
import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/features/auth/presentation/widget/matrial_botton.dart';
import 'package:ccount/features/auth/presentation/widget/page_view_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Onbordinge extends StatelessWidget {
  const Onbordinge({super.key});

  @override
  Widget build(BuildContext context) {
    OnbordingeControllerPage bordController =
        Get.put(OnbordingeControllerPage());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 1,
          surfaceTintColor: const Color.fromARGB(31, 255, 255, 255),
        ),
        // backgroundColor: AppColor.praimaryColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              const Expanded(
                child: PageViewBuilder(),
              ),
              // SizedBox(
              //   height: 40.h,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<OnbordingeControllerPage>(builder: (controlle) {
                      return MatrialBottonW(
                        vertical: 10,
                        paddHorizontal: 80,
                        onPressed: () {
                          controlle.nextPage();
                        },
                        text: "7".tr,
                        colorBackRound: AppColor.praimaryColorBlue,
                        colorText: AppColor.praimaryColorGreen,
                      );
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<OnbordingeControllerPage>(builder: (controlle) {
                      return MatrialBottonW(
                        vertical: 10,
                        paddHorizontal: 80,
                        onPressed: () {
                          controlle.skipPage();
                        },
                        text: "8".tr,
                        colorBackRound: AppColor.praimaryColorGreen,
                        colorText: AppColor.praimaryColorBlue,
                      );
                    })
                  ],
                ),
              ),

              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ));
  }
}

