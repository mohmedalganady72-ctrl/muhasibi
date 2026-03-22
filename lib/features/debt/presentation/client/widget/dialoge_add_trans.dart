import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';

import 'package:ccount/features/debt/presentation/controllers/transaction_controlle.dart';
import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/constant/app_size.dart';
import 'package:ccount/core/function/date_time.dart';
import 'package:ccount/core/function/pric_formatter.dart';
import 'package:ccount/core/shared/data_file.dart';
import 'package:ccount/core/shared/phone_filed.dart';
import 'package:ccount/core/shared/row_filde_icon.dart';
import 'package:ccount/core/shared/text_form_filed.dart';

import 'package:ccount/features/debt/data/models/currency_model.dart';
import 'package:ccount/features/auth/presentation/widget/matrial_botton.dart';
import 'package:ccount/features/debt/presentation/client/view/currncy_screen.dart';
import 'package:ccount/features/debt/presentation/client/widget/drop_down_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class DialogAddTrans extends StatelessWidget {
  // String? initVal;
  // TransactionControlle? client;
  // String? cCode;
  // int? id;
  bool? edit;
  int? index;
  DialogAddTrans({super.key, this.edit, this.index});

  @override
  Widget build(BuildContext context) {
    // NewClientAddController control = Get.put(NewClientAddController());

/*

 !_controller.edit
                      ? "38".tr
                      : _controller.tranEdit
                          ? "معلومات العمليه"
                          : "تعديل العملية",
*/
    return AlertDialog(
      // iconColor: Colors.black,

      elevation: 0,
      actionsAlignment: MainAxisAlignment.center,
      title: Center(
          child: GetBuilder<TransactionControlle>(
        builder: (_controller) => Text(
          _controller.edit
              ? _controller.tranEdit
                  ? "تعديل العملية"
                  : "معلومات العملية"
              : "38".tr,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )),

      content: SizedBox(
        width: double.maxFinite,
        // height: 250.h,
        child: SingleChildScrollView(
          child: GetBuilder<TransactionControlle>(
            builder: (_controller) => Form(
              key: _controller.formkeyTeansaction,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(child: const Icon(Iconsax.user)),

                  // RowFieldIcon(
                  //   childPrefix: Icon(
                  //     Iconsax.user,
                  //     size: AppSize.iconDialogeInfo,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  //   childField: TextFormFieldWidget(
                  //     hintText: "32".tr,
                  //     controller: client!,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "28".tr;
                  //       }

                  //       return null;
                  //     },
                  //     keyboardType: TextInputType.name,
                  //   ),
                  // ),

                  SizedBox(height: 10.h),

                  // RowFieldIcon(
                  //   childPrefix:
                  //       Icon(Iconsax.call_add, size: AppSize.iconDialogeInfo),
                  //   childField: TextFormFieldWidget(
                  //     hintText: "33".tr,
                  //     keyboardType: TextInputType.phone,
                  //     controller: client!.clientPhoneController,
                  //     validator: (value) {
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 10.h),
                  AbsorbPointer(
                    absorbing: _controller.edit,
                    child: RowFieldIcon(
                      childPrefix: Icon(Iconsax.dollar_square,
                          size: AppSize.iconDialogeInfo),
                      childField: TextFormFieldWidget(
                        edit: _controller.edit,
                        hintText: "39".tr,
                        maxLinth: 12,
                        // maxLinth: 9,
                        onChanged: (Value) {
                          if (Value.isEmpty) return;
                          amontFormatter(_controller.peice, Value);
                        },
                        keyboardType: TextInputType.number,
                        controller: _controller.peice,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "28".tr;
                          }
                          return null;
                        },
                      ),
                      //     TextFormField(
                      //   controller: _controller.peice,
                      //   keyboardType: TextInputType.number,
                      //   maxLength: 9,
                      //   decoration: InputDecoration(hintText: "price"),
                      //   onChanged: (value) {
                      //     amontFormatter(_controller.peice, value);
                      //   },
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "28".tr;
                      //     }
                      //     return null;
                      //   },
                      // ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GetBuilder<TransactionControlle>(
                    builder: (_controllerr) => AbsorbPointer(
                      absorbing: _controllerr.edit,
                      child: GestureDetector(
                        onTap: () {
                          _controllerr.edit
                              ? _controllerr.getDataTimerCelunderEdit(
                                  context, _controllerr.dt!)
                              : _controllerr.getDataTimerCelunder(context);
                        },
                        trackpadScrollCausesScale: true,
                        child: RowFieldIcon(
                          childPrefix: Icon(Iconsax.calendar_edit,
                              size: AppSize.iconDialogeInfo),
                          childField: GestureDetector(
                            onTap: () {
                              _controllerr.edit
                                  ? _controllerr.getDataTimerCelunderEdit(
                                      context, _controllerr.dt!)
                                  : _controllerr.getDataTimerCelunder(context);
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: DataField(
                                edit: _controller.edit,
                                controller: _controllerr.dateTimeTransaction,

                                // initialValue: "${controller.clientDate}"
                                //     "${controller.clientTime}",
                                // readOnly: true,
                                color: AppColor.filleTextFiled,
                                keyboardType: TextInputType.datetime,
                                // controller: TextEditingController(),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  AbsorbPointer(
                    absorbing: _controller.edit,
                    child: RowFieldIcon(
                      childPrefix: Icon(Icons.description_outlined,
                          size: AppSize.iconDialogeInfo),
                      childField: AbsorbPointer(
                        absorbing: _controller.edit,
                        child: TextFormFieldWidget(
                          edit: _controller.edit,
                          // edit: true,
                          maxLine: 3,
                          hintText: "التفاصيل",
                          keyboardType: TextInputType.text,
                          controller: _controller.nots,
                          validator: (value) {
                            return null;
                          },
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        GetBuilder<TransactionControlle>(
          builder: (controll) => !edit!
              ? MatrialBottonW(
                  minWidth: double.maxFinite,
                  text: "29".tr,
                  colorBackRound: controll.isLow!
                      ? AppColor.minusColor
                      : AppColor.plusColor,
                  colorText: Colors.white,
                  paddHorizontal: 80.w,
                  vertical: 8.h,
                  onPressed: () async {
                    await controll.addTransacrtion();
                    // add check box to back
                    // client!.refresh();
                    // Get.back();
                    // controll.cleareControllers();
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controll.deletTransaction(index!, controll.isLow!);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: controll.isLow!
                                  ? AppColor.minusColor
                                  : AppColor.plusColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 22.w),
                          child: Text(
                            "حذف",
                            style: TextStyle(
                                fontSize: AppSize.textBottonSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    GetBuilder<TransactionControlle>(
                      builder: (_controller) => GestureDetector(
                        onTap: () {
                          !_controller.edit
                              ? _controller.updateTransacrtion()
                              : _controller.changeBollEdit();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: controll.isLow!
                                    ? AppColor.minusColor
                                    : AppColor.plusColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 22.w),
                            child: Text(
                              _controller.edit ? "تعديل" : "save",
                              style: TextStyle(
                                  fontSize: AppSize.textBottonSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              color: controll.isLow!
                                  ? AppColor.minusColor
                                  : AppColor.plusColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 22.w),
                          child: Text(
                            "مشاركة",
                            style: TextStyle(
                                fontSize: AppSize.textBottonSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}

