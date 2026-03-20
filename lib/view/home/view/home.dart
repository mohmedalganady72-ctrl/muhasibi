import 'package:ccount/controller/home-controller.dart';
import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/list-page.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';

import 'package:ccount/view/debt/client/view/client-screen.dart';
import 'package:ccount/view/debt/supplier/view/supplier-screen.dart';
import 'package:ccount/view/debt/view/suplier-screent.dart';
import 'package:ccount/view/setting/view/more-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

//to stless all
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) => SizedBox(
                height: 50.h,
                child: Container(
                  decoration: BoxDecoration(
                      //   boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black.withOpacity(0.1),
                      //       spreadRadius: 2,
                      //       blurRadius: 10,
                      //       offset: Offset(0, 5))
                      // ]
                      border: Border(
                          top: BorderSide(
                              color: Colors.grey.shade50, width: 2.5))),
                  // padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  // color: Color.fromARGB(255, 250, 250, 250),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: !(controller.selectedIndex != 0)
                                      ? BorderSide(
                                          color: AppColor.IconButton,
                                          width: 2.5,
                                          style: BorderStyle.solid)
                                      : BorderSide.none)),
                          child: GestureDetector(
                            onTap: () {
                              controller.changeIndex(0);
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.user_tag,
                                    size: 25.sp,
                                    color: controller.selectedIndex != 0
                                        ? AppColor.iNoSelected
                                        : null),
                                Text(
                                  "17".tr,
                                  style: TextStyleTheme.bottomNavBar(
                                      controller.selectedIndex != 0
                                          ? AppColor.iNoSelected
                                          : AppColor.IconButton),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: !(controller.selectedIndex != 1)
                                      ? BorderSide(
                                          color: AppColor.IconButton,
                                          width: 2.5,
                                          style: BorderStyle.solid)
                                      : BorderSide.none)),
                          child: GestureDetector(
                            onTap: () {
                              controller.changeIndex(1);
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.truck,
                                    size: 25.sp,
                                    color: controller.selectedIndex != 1
                                        ? AppColor.iNoSelected
                                        : null),
                                Text(
                                  "48".tr,
                                  style: TextStyleTheme.bottomNavBar(
                                      controller.selectedIndex != 1
                                          ? AppColor.iNoSelected
                                          : AppColor.IconButton),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: !(controller.selectedIndex != 2)
                                      ? BorderSide(
                                          color: AppColor.IconButton,
                                          width: 2.5,
                                          style: BorderStyle.solid)
                                      : BorderSide.none)),
                          child: GestureDetector(
                            onTap: () {
                              controller.changeIndex(2);
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.wallet_3,
                                    size: 25.sp,
                                    color: controller.selectedIndex != 2
                                        ? AppColor.iNoSelected
                                        : null),
                                Text(
                                  "49".tr,
                                  style: TextStyleTheme.bottomNavBar(
                                      controller.selectedIndex != 2
                                          ? AppColor.iNoSelected
                                          : AppColor.IconButton),
                                ),
                                // Container(
                                //   width: 100,
                                //   height: 2,
                                //   color: Colors.black,
                                // )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: !(controller.selectedIndex != 3)
                                      ? BorderSide(
                                          color: AppColor.IconButton,
                                          width: 2.5,
                                          style: BorderStyle.solid)
                                      : BorderSide.none)),
                          child: GestureDetector(
                            onTap: () {
                              controller.changeIndex(3);
                            },
                            child: Column(
                              children: [
                                Icon(Iconsax.more,
                                    size: 25.sp,
                                    color: controller.selectedIndex != 3
                                        ? AppColor.iNoSelected
                                        : null),
                                Text(
                                  "50".tr,
                                  style: TextStyleTheme.bottomNavBar(
                                      controller.selectedIndex != 3
                                          ? AppColor.iNoSelected
                                          : AppColor.IconButton),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),

      // body: GetBuilder<HomeController>(
      //   builder: (control) =>
      //       buildFooterButtons.elementAt(control.selectedIndex),
      // ),

      /* 
        const CashRegister(),
  ClientScreen(),
  const SupplierScreen(),
  const MoreScreen(),
      
      */
      body: GetBuilder<HomeController>(
        builder: (control) {
          switch (control.selectedIndex) {
            case 1:
              return SuplierScreent();
            case 0:
              return ClientScreen();

            case 2:
              return MoreScreen();
            default:
              return MoreScreen();
          }
        },
      ),
    );
  }
}
