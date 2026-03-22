import 'dart:io';

import 'package:ccount/features/debt/presentation/controllers/transaction_controlle.dart';
import 'package:ccount/core/constant/app_image.dart';
import 'package:ccount/core/constant/app_page.dart';
import 'package:ccount/core/function/pric_formatter.dart';
import 'package:ccount/core/function/send_massage.dart';
import 'package:ccount/core/shared/floating_botton.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:ccount/features/debt/presentation/client/view/edite_info_client.dart';
import 'package:ccount/features/debt/presentation/client/view/note_client_edit.dart';
import 'package:ccount/features/debt/presentation/client/widget/columen_icon_widget.dart';
import 'package:ccount/features/debt/presentation/client/widget/dialoge_add_info_client.dart';
import 'package:ccount/features/debt/presentation/client/widget/dialoge_add_trans.dart';
import 'package:ccount/features/debt/presentation/client/widget/dialoge_crate_report_transaction.dart';
import 'package:ccount/features/debt/presentation/client/widget/row_icon_data_info.dart';
import 'package:ccount/features/home/presentation/view/home.dart';
import 'package:device_preview/device_preview.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';

import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/services/service.dart';
import 'package:ccount/core/shared/container_icon.dart';
import 'package:ccount/core/shared/text_form_filed.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';

import 'package:ccount/features/debt/data/models/box_model.dart';
import 'package:ccount/features/debt/presentation/client/view/page_client_transaction.dart';
import 'package:ccount/features/debt/presentation/client/widget/list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';

class PageClientTransaction extends StatelessWidget {
  PageClientTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionControlle ctrl = Get.put(TransactionControlle());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10.h),
        child: GetBuilder<TransactionControlle>(builder: (_controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingButton(
                label: "45".tr,
                onTap: () {
                  _controller.clearControllers();
                  _controller.changeBottonHigth();
                  _controller.initDateTime();
                  _controller.changeBollEdit();
                  showDialog(
                    context: context,
                    builder: (context) => DialogAddTrans(
                      edit: false,
                    ),
                  );
                },
                icon: EvaIcons.trendingUp,

                // colorIcon: Colors.green.shade100,
                colorIcon: AppColor.plusColor,
                colorback: Colors.white,
                colorText: AppColor.plusColor,
                sizeIcon: 35,
              ),
              FloatingButton(
                label: "46".tr,
                onTap: () {
                  _controller.clearControllers();
                  _controller.changeBottonLow();
                  _controller.initDateTime();
                  _controller.changeBollEdit();
                  showDialog(
                    context: context,
                    builder: (context) => DialogAddTrans(
                      edit: false,
                    ),
                  );
                },
                icon: EvaIcons.trendingDown,
                colorIcon: AppColor.minusColor,
                colorback: Colors.white,
                colorText: AppColor.minusColor,
                sizeIcon: 30,
              ),
            ],
          );
        }),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.off(() => Home(),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));
              },
              icon: Icon(Iconsax.arrow_left_2))
        ],
        scrolledUnderElevation: 0,
        title: Text("66".tr),
      ),
      body: GetBuilder<TransactionControlle>(
        builder: (_controllerr) => _controllerr.stateData == false
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // معلومات العميل

                        GestureDetector(
                          onTap: () {
                            Get.off(() => EditeInfoClient(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 300),
                                arguments: ctrl.data);

                            // .then((_) async => await ctrl.refrshEditeInfoClient());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColor.prymary1
                                  : Colors.white,
                              border: Border.all(
                                  color: AppColor.backgroundIcon,
                                  width: 2.w,
                                  style: BorderStyle.solid),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: GetBuilder<TransactionControlle>(
                                          builder: (_control) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              RowIconData(
                                                icon: Iconsax.user,
                                                text: Expanded(
                                                  child: Text(
                                                      "${_control.data!.name}",
                                                      style: TextStyle(
                                                        fontSize: 14.5.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              RowIconData(
                                                icon: Iconsax.call,
                                                text: Expanded(
                                                  child: Text(
                                                    "${_control.data!.phone == "" ? "35".tr : _control.data!.phone}",
                                                    style: _control
                                                                .data!.phone ==
                                                            ""
                                                        ? TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.grey)
                                                        : TextStyle(
                                                            fontSize: 14.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              RowIconData(
                                                icon: Iconsax.location,
                                                text: Expanded(
                                                  child: Text(
                                                      "${_control.data!.address == "" ? "35".tr : _control.data!.address}",
                                                      style: _control.data!
                                                                  .address ==
                                                              ""
                                                          ? TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.grey)
                                                          : TextStyle(
                                                              fontSize: 14.5.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GetBuilder<TransactionControlle>(
                                        builder: (_controllerr) => Container(
                                          padding: EdgeInsets.all(2),
                                          constraints: BoxConstraints(
                                              minHeight: 100.h,
                                              minWidth: 100.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            border: Border.all(
                                              color: _controllerr.data!
                                                          .pathImageProfile! ==
                                                      AppImage.userProfile
                                                  ? Colors.blue.shade100
                                                  : Color.fromARGB(
                                                      255, 85, 151, 227),
                                              width: 3.5.w,
                                            ),
                                          ),
                                          child: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: 90.h,
                                                  minWidth: 90.w),
                                              decoration: BoxDecoration(
                                                color: _controllerr.data!
                                                            .pathImageProfile! ==
                                                        AppImage.userProfile
                                                    ? AppColor.backgroundIcon
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                              child: CircleAvatar(
                                                radius: 50.w,
                                                backgroundColor:
                                                    AppColor.filleTextFiled,
                                                backgroundImage: _controllerr
                                                            .data!
                                                            .pathImageProfile! !=
                                                        AppImage.userProfile
                                                    ? FileImage(File(
                                                        _controllerr.data!
                                                            .pathImageProfile!))
                                                    : null,
                                                child: _controllerr.data!
                                                            .pathImageProfile! ==
                                                        AppImage.userProfile
                                                    ? Center(
                                                        child: Text(
                                                          "${_controllerr.data!.name!.substring(0, 1)}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 28.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      )
                                                    : null,
                                              )

                                              //  ClipRRect(
                                              //   borderRadius: BorderRadius.circular(1000),
                                              //   child:
                                              //       _controllerr.data!.pathImageProfile! ==
                                              //               AppImage.userProfile
                                              //           ? Center(
                                              //               child:
                                              // Text(
                                              //                 "${_controllerr.data!.name!.substring(0, 1)}",
                                              //                 textAlign: TextAlign.center,
                                              //                 style: TextStyle(
                                              //                   fontSize: 26.sp,
                                              //                   fontWeight: FontWeight.w600,
                                              //                 ),
                                              //               ),
                                              //             )
                                              //           : Image(
                                              //               image: ResizeImage(
                                              //                 width: (90.w).toInt(),
                                              //                 height: (90.h).toInt(),
                                              //                 FileImage(
                                              //                   File(_controllerr.data!
                                              //                       .pathImageProfile!),
                                              //                 ),
                                              //               ),
                                              //               fit: BoxFit.cover,
                                              //             ),
                                              // ),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  // المجموع
                                  GetBuilder<TransactionControlle>(
                                      builder: (_contolerr) {
                                    return Text(
                                      "${_contolerr.data!.currncy} ${chaongToPricFormatter(_contolerr.total!.abs().toString())}",
                                      // Text(
                                      //   "${_contolerr.data!.currncy} ${chaongToPricFormatter(_contolerr.total!.abs().toString())}",
                                      style: _contolerr.total! >= 0
                                          ? TextStyleTheme.Total(
                                              AppColor.plusColor)
                                          : TextStyleTheme.Total(
                                              AppColor.minusColor),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),
                        // أيقونات العمليات
                        GetBuilder<TransactionControlle>(
                            builder: (_controller) => _controller
                                    .selectedIndex.isEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          _controller
                                              .onTapReport(_controller.rows);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogCreateReportTransaction();
                                            },
                                          );
                                        },
                                        child: buildIconColumn(
                                            Iconsax.bill, "42".tr, null, null),
                                      ),
                                      GestureDetector(
                                          onTap: () async => await _controller
                                              .openDialer(context),
                                          child: buildIconColumn(
                                              Iconsax.call_calling,
                                              "41".tr,
                                              null,
                                              null)),
                                      GestureDetector(
                                          onTap: () {
                                            // Navigator.pop(context);
                                            sendSMS(
                                                "+967${_controller.data!.phone}",
                                                "welcome dsdgds");
                                            // showMessageSheet(
                                            //     context, "${_controller.data!.phone}", "welcome");
                                          },
                                          child: buildIconColumn(
                                              Iconsax.message,
                                              "40".tr,
                                              null,
                                              null)),
                                      buildIconColumn(Iconsax.notification,
                                          "43".tr, null, null),
                                      GestureDetector(
                                          onTap: () {
                                            _controller.goToNote();
                                          },
                                          child: buildIconColumn(
                                              Iconsax.note_text,
                                              "44".tr,
                                              null,
                                              null)),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                        GestureDetector(
                                          onTap: () async {
                                            _controller
                                                .onTapReport(_controller.rows);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DialogCreateReportTransaction();
                                              },
                                            );
                                          },
                                          child: buildIconColumn(
                                              Iconsax.bill,
                                              "42".tr,
                                              AppColor.IconButton,
                                              AppColor.backgroundIcon),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await _controller
                                                .removeSelectedTransaction();
                                          },
                                          child: buildIconColumn(
                                              Iconsax.trash,
                                              "حذف",
                                              AppColor.IconButton,
                                              AppColor.backgroundIcon),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            _controller
                                                .onTapReport(_controller.rows);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DialogCreateReportTransaction();
                                              },
                                            );
                                          },
                                          child: buildIconColumn(
                                              Iconsax.arrow_swap_horizontal,
                                              "67".tr,
                                              AppColor.IconButton,
                                              AppColor.backgroundIcon),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              // Navigator.pop(context);
                                              sendSMS(
                                                  "+967${_controller.data!.phone}",
                                                  "welcome ");
                                              // showMessageSheet(
                                              //     context, "${_controller.data!.phone}", "welcome");
                                            },
                                            child: buildIconColumn(
                                                Iconsax.message,
                                                "40".tr,
                                                AppColor.IconButton,
                                                AppColor.backgroundIcon)),
                                      ])),

                        SizedBox(height: 20.h),
                        // جدول المعاملات
                        // Expanded(
                        //   child
                        //   :

                        GetBuilder<TransactionControlle>(
                          builder: (_controller) => !_controller.state
                              ? Center(child: Text("loading....."))
                              : _controller.rows.isEmpty
                                  ? Expanded(
                                      child: Center(child: Text("68".tr)))
                                  : Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Table(
                                            border: TableBorder.symmetric(
                                              outside: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                            children: [
                                              // ترويسة الجدول
                                              TableRow(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100),
                                                  children: [
                                                    GetBuilder<
                                                        TransactionControlle>(
                                                      builder: (_controller) =>
                                                          Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment.start,

                                                          mainAxisAlignment: _controller
                                                                  .selectedIndex
                                                                  .isEmpty
                                                              ? MainAxisAlignment
                                                                  .center
                                                              : MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Visibility(
                                                                visible: !_controller
                                                                    .selectedIndex
                                                                    .isEmpty,
                                                                child: SizedBox(
                                                                  height: 18.h,
                                                                  width: 33.w,
                                                                  child: Checkbox(
                                                                      onChanged: (Value) {
                                                                        if (Value!) {
                                                                          _controller
                                                                              .selectRowAddAll();
                                                                        } else {
                                                                          _controller
                                                                              .selectRowRmoveAll();
                                                                        }
                                                                      },
                                                                      value: _controller.valeCheckAll),
                                                                )),
                                                            !_controller
                                                                    .selectedIndex
                                                                    .isEmpty
                                                                ? SizedBox(
                                                                    width: 25.w,
                                                                  )
                                                                : SizedBox(),
                                                            Text(
                                                              _controller
                                                                  .culomen[0],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        _controller.culomen[1],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        _controller.culomen[2],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]
                                                  // List.generate(0, (index) => null)
                                                  //  _controller.culomen
                                                  //     .map(
                                                  //       (c) =>
                                                  //  Padding(
                                                  //   padding: EdgeInsets.all(8),
                                                  //   child: Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment.center,
                                                  //     children: [
                                                  //       Visibility(
                                                  //           child: Checkbox(
                                                  //         onChanged: (Value) {},
                                                  //         value: true,
                                                  //       )),
                                                  //       Text(
                                                  //         c,
                                                  //         textAlign: TextAlign.center,
                                                  //         style: TextStyle(
                                                  //             fontWeight:
                                                  //                 FontWeight.bold),
                                                  //       ),
                                                  //     ],
                                                  //   ),

                                                  //         //  Text(
                                                  //         //   c,
                                                  //         //   textAlign: TextAlign.center,
                                                  //         //   style: TextStyle(
                                                  //         //       fontWeight:
                                                  //         //           FontWeight.bold),
                                                  //         // ),
                                                  //       ),
                                                  //     )
                                                  //     .toList(),
                                                  ),
                                              // الصفوف
                                            ],
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: GetBuilder<
                                                  TransactionControlle>(
                                                builder: (_controllerr) =>
                                                    Table(
                                                  border: TableBorder.symmetric(
                                                    outside: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                  ),
                                                  children: List.generate(
                                                      _controllerr.rows.length,
                                                      (index) {
                                                    final row = _controllerr
                                                        .rows[index];
                                                    final isSelected =
                                                        _controllerr
                                                            .selectedIndex
                                                            .contains(index);
                                                    return TableRow(
                                                      decoration: BoxDecoration(
                                                          color: index % 2 == 0
                                                              ? Colors
                                                                  .grey.shade100
                                                              : Colors.white),
                                                      children: [
                                                        GestureDetector(
                                                          onLongPress: () {
                                                            if (_controllerr
                                                                .selectedIndex
                                                                .isEmpty) {
                                                              _controllerr
                                                                  .selectRowAdd(
                                                                      index);
                                                            }
                                                          },
                                                          onTap: () {
                                                            if (!_controllerr
                                                                .selectedIndex
                                                                .isEmpty) {
                                                              isSelected
                                                                  ? _controllerr
                                                                      .selectRowRmove(
                                                                          index)
                                                                  : _controllerr
                                                                      .selectRowAdd(
                                                                          index);
                                                            } else {
                                                              _controller
                                                                  .getDataTransToEdit(
                                                                      row);
                                                              row.lakom != 0
                                                                  ? _controller
                                                                      .changeBottonHigth()
                                                                  : _controller
                                                                      .changeBottonLow();
                                                              // _controller.initDateTime();
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        DialogAddTrans(
                                                                  edit: true,
                                                                  index: index,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        8),
                                                            // child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Visibility(
                                                                    visible: !_controllerr
                                                                        .selectedIndex
                                                                        .isEmpty,
                                                                    child:
                                                                        Checkbox(
                                                                      onChanged:
                                                                          (Value) {
                                                                        if (Value!) {
                                                                          _controllerr
                                                                              .selectRowAdd(index);
                                                                        } else {
                                                                          _controllerr
                                                                              .selectRowRmove(index);
                                                                        }
                                                                      },
                                                                      value:
                                                                          isSelected,
                                                                    )),
                                                                Text(
                                                                    "${row.dateUser}\n${row.timeUser}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Center(
                                                              child: Text(
                                                                  "${row.remarks}")),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Center(
                                                            child: Text(
                                                              row.lakom == 0
                                                                  ? chaongToPricFormatter(row
                                                                      .alikom
                                                                      .toString())
                                                                  : chaongToPricFormatter(row
                                                                      .lakom
                                                                      .toString()),
                                                              style: TextStyle(
                                                                  color: row.lakom !=
                                                                          0
                                                                      ? AppColor
                                                                          .plusColor
                                                                      : AppColor
                                                                          .minusColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // Column buildIconColumn(IconData icon, String label) {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 5),
  //         child: ContainerIcon(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Icon(icon),
  //           ),
  //         ),
  //       ),
  //       Text(label, style: TextStyleTheme.caption)
  //     ],
  //   );
  // }
}

