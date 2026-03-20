import 'package:ccount/controller/client-controller.dart';
import 'package:ccount/controller/currnct-controller.dart';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/shared/container-icon.dart';
import 'package:ccount/view/debt/client/widget/dialoge-add-info-client.dart';
import 'package:ccount/core/shared/floating-botton.dart';
import 'package:ccount/core/shared/page-currncy-widget.dart';
import 'package:ccount/core/shared/phone-filed.dart';
import 'package:ccount/core/shared/text-form-filed.dart';

import 'package:ccount/view/auth/widget/matrial-botton.dart';
import 'package:ccount/view/debt/client/view/client-screen.dart';

import 'package:ccount/view/debt/client/widget/matrial-App-Bar.dart';
import 'package:ccount/view/home/view/home.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class CurrncyScreen extends StatelessWidget {
  const CurrncyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CurrncyController ctrl = Get.put(CurrncyController());
    // ClientController ctrlFind = Get.find<ClientController>();

    // final NewClientAddController ncac = Get.find()<NewClientAddController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text("23".tr),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () async {
                  Get.off(() => Home(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 300));
                },
                icon: Icon(Iconsax.arrow_left2)),
          )
        ],
      ),
      // backgroundColor: const Color.fromARGB(255, 160, 61, 61),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Form(
                        key: ctrl.currncyFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text("24".tr),
                                  ),
                                  // Expanded(
                                  //   child:
                                  SizedBox(
                                    height: 15.w,
                                  ),
                                  GetBuilder<CurrncyController>(
                                    builder: (_controllerr) =>
                                        TextFormFieldWidget(
                                      // prefixIcon: const Icon(Icons.location_on),
                                      suffixIcon: _controllerr.errorIconName,
                                      keyboardType: TextInputType.name,
                                      hintText: "26".tr,
                                      // label: "10".tr,
                                      controller: ctrl.nameCurrncyController,
                                      onChanged: (valeu) {
                                        if (valeu.isEmpty ||
                                            valeu.toString().trim().isEmpty) {
                                          _controllerr.setIconErrorName();
                                        } else {
                                          _controllerr.setIconErrorTrueName();
                                        }
                                      },
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.w,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text("25".tr),
                                  ),
                                  // Expanded(
                                  //   child:
                                  SizedBox(
                                    height: 15.w,
                                  ),
                                  GetBuilder<CurrncyController>(
                                    builder: (_controllerre) =>
                                        TextFormFieldWidget(
                                      // prefixIcon: const Icon(Icons.location_on),
                                      suffixIcon: _controllerre.errorIconCode,
                                      keyboardType: TextInputType.name,
                                      hintText: "27".tr,
                                      // label: "10".tr,
                                      controller: ctrl.codeCurrncyController,
                                      onChanged: (valeu) {
                                        if (valeu.isEmpty ||
                                            valeu.toString().trim().isEmpty) {
                                          _controllerre.setIconErrorCode();
                                        } else {
                                          _controllerre.setIconErrorTrueCode();
                                        }
                                      },
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      MatrialBottonW(
                        onPressed: () {
                          ctrl.addNewCurrncyClinet();
                        },
                        colorBackRound: AppColor.Selected,
                        colorText: AppColor.Selected,
                        text: "29".tr,
                        paddHorizontal: 90.w,
                        vertical: 10,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 15.h,
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5.h,
                  ),
                ),
                SliverAppBar(
                  // stretch: true,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  surfaceTintColor: Colors.transparent,
                  title: Text("30".tr),
                  floating: true,
                  pinned: true,

                  // ),
                ),
              ];
            },
            body: GetBuilder<CurrncyController>(builder: (controller) {
              if (!controller.isDataView) {
                // حالة التحميل
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // حالة البيانات
                if (controller.codes.isEmpty) {
                  return Center(
                    child: Text("47".tr),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: ListView.builder(
                      itemCount: controller.codes.length,
                      itemBuilder: (context, index) {
                        // return InkWell(
                        //   onTap: () {},

                        //   child:
                        return Container(
                          // decoration: BoxDecoration(border: Border.symmetric(vertical: ) ),

                          // decoration: ,
                          child: Card(
                            elevation: 0,
                            // color: Color.fromARGB(119, 175, 238, 255),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // side: BorderSide.none()
                              // side: BorderSide.strokeAlignOutside(
                              //   color: AppColor.borderCard,
                              //   width: 1,
                              //   strokeAlign: 5,
                              // ),
                            ),
                            child: ListTile(
                              leading: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.sp,
                                  vertical: 10.sp,
                                ),
                                child: Text(
                                  "${controller.codes[index].code}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${controller.codes[index].name}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    // child: ContainerIcon(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Iconsax.edit,
                                      size: 30,
                                      color: AppColor.IconButton,
                                    ),
                                  ),
                                  // ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    // child: ContainerIcon(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Iconsax.close_square,
                                      size: 30,
                                      color: AppColor.IconButton,
                                    ),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           },
                                    //         ),
                                    //       );
                                    //     }
                                    //   }
                                    // },
                                  ),
                                  // ),
                                  // ),
                                ],
                              ),
                            ),
                            // ),
                            // ),
                          ),
                        );
                      },

                      // Center(child: Text(' USD')),
                      // Obx(() => clientController.pageList.isNotEmpty
                      //     ? clientController
                      //         .pageList[clientController.selectedIndex!.value]
                      //     : const Center(child: Text('No Data'))),
                    ),
                  );
                }
              }
            })),
      ),
      // )
      // ),
    );
    // );
  }
}
