import 'dart:io';

import 'package:ccount/controller/client-controller.dart';
import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/function/pric-formatter.dart';
import 'package:ccount/core/function/report-clients.dart';
import 'package:ccount/core/shared/container-icon.dart';
import 'package:ccount/core/shared/dialog-create-report.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:ccount/view/debt/client/view/add-new-client-screen.dart';
import 'package:ccount/view/debt/client/view/page-client-transaction.dart';
import 'package:ccount/view/debt/client/widget/card-client.dart';
import 'package:ccount/view/debt/client/widget/dialoge-add-info-client.dart';
import 'package:ccount/core/shared/floating-botton.dart';
import 'package:ccount/core/shared/text-form-filed.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/widget/filtter-dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';

class ClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ClientController _ctrl = Get.put(ClientController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: GetBuilder<ClientController>(
        builder: (control) => SizedBox(
          // height: 50.h,
          child: FloatingButton(
            radios: 50,
            hortin: 100.w,
            label: "18".tr,
            icon: Iconsax.user_add,
            sizeIcon: 25,
            onTap: () async {
              // control.showDialogeAddClient(context, control.boxMod.currncy);

              control.cleareControllers();

              control.initDateTime();

              control.goToAddNewClient();
            },
          ),
        ),
      ),

      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('17'.tr),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<ClientController>(
        builder: (ctrll) => ctrll.st == false
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35.h,

                    // currncy list
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                          // hear row of currncy
                          Row(children: [
                        ...List.generate(
                          ctrll.crncList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              // ctrll.selectTab(index);
                              ctrll.getItem(index, ctrll.crncList[index]);
                            },
                            // center childe of tab currncy
                            child: Center(
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 75.w, // أقل عرض
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: index == ctrll.selectee
                                      ? AppColor.backgroundButton
                                      : AppColor.borderCard,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "${ctrll.crncList[index]}",
                                    style: TextStyle(
                                      fontWeight: index == ctrll.selectee
                                          ? FontWeight.w900
                                          : FontWeight.w700,
                                      color: index == ctrll.selectee
                                          ? Colors.white
                                          : AppColor.backgroundButton,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            _ctrl.goToAddNewCurrncy();

                            // ctrll.dispose();
                          },
                          child: Center(
                            child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 75.w, // أقل عرض
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColor.borderCard,
                                ),
                                child: Center(
                                  child: Icon(
                                    Iconsax.add,
                                    // weight: 10,
                                    size: 35,
                                    // opticalSize: 20,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),

                  SizedBox(height: 10),

                  // ✅ باقي الصفحة
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<ClientController>(
                        builder: (controllerPage) => controllerPage.boxMod ==
                                null
                            ? Center(child: CircularProgressIndicator())
                            : NestedScrollView(
                                headerSliverBuilder:
                                    (context, innerBoxIsScrolled) {
                                  return [
                                    SliverToBoxAdapter(
                                      //
                                      //  contriner carde
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColor.backgroundButton
                                              : Colors.white,
                                          border: Border.all(
                                            color: AppColor.backgroundIcon,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("57".tr,
                                                          style: TextStyleTheme
                                                              .heading2),
                                                      GetBuilder<
                                                          ClientController>(
                                                        builder: (controller) {
                                                          return controller
                                                                  .issel!
                                                              ? Text(
                                                                  "************* ${controller.boxMod!.currncyCode}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyleTheme
                                                                      .priceStyle(
                                                                          AppColor
                                                                              .plusColor))
                                                              : Text(
                                                                  "${controller.boxMod!.currncyCode} ${chaongToPricFormatter((controller.boxMod!.laho!.abs()).toString())}",
                                                                  style: TextStyleTheme
                                                                      .priceStyle(
                                                                          AppColor
                                                                              .plusColor),
                                                                );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("58".tr,
                                                          style: TextStyleTheme
                                                              .heading2),
                                                      GetBuilder<
                                                          ClientController>(
                                                        builder: (c) {
                                                          return c.issel!
                                                              ? Text(
                                                                  "************* ${c.boxMod!.currncyCode}",
                                                                  style: TextStyleTheme
                                                                      .priceStyle(
                                                                          AppColor
                                                                              .minusColor))
                                                              : Text(
                                                                  "${c.boxMod!.currncyCode} ${chaongToPricFormatter((c.boxMod!.alihe!.abs()).toString())}",
                                                                  style: TextStyleTheme
                                                                      .priceStyle(
                                                                          AppColor
                                                                              .minusColor),
                                                                );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("59".tr,
                                                          style: TextStyleTheme
                                                              .heading2),
                                                      GetBuilder<
                                                          ClientController>(
                                                        builder: (c) {
                                                          final total = (c
                                                                  .boxMod!
                                                                  .laho! -
                                                              c.boxMod!.alihe!);
                                                          return c.issel!
                                                              ? Text(
                                                                  "************* ${c.boxMod!.currncyCode}",
                                                                  style: TextStyleTheme
                                                                      .priceStyle(
                                                                          AppColor
                                                                              .starColor))
                                                              : Text(
                                                                  "${c.boxMod!.currncyCode} ${chaongToPricFormatter(total.abs().toString())}",
                                                                  style: total <
                                                                          0
                                                                      ? TextStyleTheme.Total(
                                                                          AppColor
                                                                              .minusColor)
                                                                      : TextStyleTheme.Total(
                                                                          AppColor
                                                                              .plusColor),
                                                                );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Iconsax.user,
                                                          size: 25.sp,
                                                          color: AppColor
                                                              .prymary1),
                                                    ),
                                                    SizedBox(height: 3.h),
                                                    GetBuilder<
                                                        ClientController>(
                                                      builder: (_c) => _c
                                                              .data.isEmpty
                                                          ? Text("0")
                                                          : Text(
                                                              "${_c.data.length}",
                                                              // "${_c.data.length}8000",
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColor
                                                                    .prymary1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20.h),
                                                GetBuilder<ClientController>(
                                                  builder: (controller) =>
                                                      GestureDetector(
                                                    onTap: () => controller
                                                        .currebtselect(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        controller.issel!
                                                            ? Iconsax.eye_slash
                                                            : Iconsax.eye,
                                                        size: 25.sp,
                                                        color:
                                                            AppColor.prymary1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                        child: SizedBox(height: 5.h)),
                                    //app bar slever
                                    SliverAppBar(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.transparent,
                                      automaticallyImplyLeading: false,
                                      title: GetBuilder<ClientController>(
                                        builder: (_controller) =>
                                            TextFormFieldWidget(
                                          onChanged: (value) {
                                            _controller.filter(value);
                                          },
                                          suffixIcon: _controller
                                                  .searchController
                                                  .text
                                                  .isNotEmpty
                                              ? IconButton(
                                                  onPressed: () {
                                                    _controller.searchController
                                                        .clear(); // يمسح النص
                                                    _controller.filter("");
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 23.sp,
                                                    color: AppColor.IconButton,
                                                  ))
                                              : null,
                                          prefixIcon: const Icon(
                                            Iconsax.search_normal,
                                            color: AppColor.maybe,
                                          ),
                                          hintText: "22".tr,
                                          keyboardType: TextInputType.text,
                                          controller:
                                              _controller.searchController,
                                          validator: (value) => null,
                                        ),
                                      ),
                                      pinned: true,
                                      actions: [
                                        GetBuilder<ClientController>(
                                          builder: (_controller) =>
                                              GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return FilterDialog(
                                                    dataClient:
                                                        _controller.data,
                                                    currncyName: _controller
                                                        .boxMod!.currncyCode,
                                                  );
                                                },
                                              );
                                            },
                                            child: ContainerIcon(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Iconsax.sort,
                                                    size: 30,
                                                    color: AppColor.prymary1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GetBuilder<ClientController>(
                                          builder: (_controller) =>
                                              GestureDetector(
                                            onTap: () async {
                                              _controller.onTapReport(
                                                  _controller.data);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogCreateReport(
                                                    dataClient:
                                                        _controller.data,
                                                    currncyName: _controller
                                                        .boxMod!.currncyCode,
                                                  );
                                                },
                                              );
                                            },
                                            child: ContainerIcon(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                    Iconsax.clipboard_export,
                                                    size: 30,
                                                    color: AppColor.prymary1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ];
                                },
                                body: GetBuilder<ClientController>(
                                  builder: (_controller) {
                                    if (_controller.data.isEmpty) {
                                      return Center(child: Text("47".tr));
                                    } else {
                                      // List<CustomerModel> clientList =
                                      //     _controller.filterClientList.reversed
                                      //         .toList();

                                      return ListView.builder(
                                        // itemExtent: 80,
                                        itemCount:
                                            _controller.filterClientList.length,
                                        itemBuilder: (context, index) {
                                          int indexed = (_controller
                                                      .filterClientList.length -
                                                  1) -
                                              index;
                                          return GestureDetector(
                                            onTap: () {
                                              _controller
                                                  .goToPageClientTransaction(
                                                      indexed,
                                                      _controller
                                                          .filterClientList[
                                                              indexed]
                                                          .id!);
                                            },
                                            child: CardClient(
                                              _controller
                                                  .filterClientList[indexed],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // ),
    );
  }
}
