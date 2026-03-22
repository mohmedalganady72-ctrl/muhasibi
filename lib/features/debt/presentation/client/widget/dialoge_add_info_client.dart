import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';

import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/constant/app_size.dart';
import 'package:ccount/core/function/date_time.dart';
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
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class DialogAddInfo extends StatelessWidget {
  String? initVal;
  ClientController? client;

  DialogAddInfo({super.key, this.initVal, this.client});

  @override
  Widget build(BuildContext context) {
    // NewClientAddController control = Get.put(NewClientAddController());

    return AlertDialog(
      elevation: 0,
      title: Center(
          child: Text(
        "31".tr,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      content: SizedBox(
        width: double.maxFinite,
        // height: 250.h,
        child: SingleChildScrollView(
          child: Form(
            key: client!.formNewClient,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                // Container(child: const Icon(Iconsax.user)),

                RowFieldIcon(
                  childPrefix: Icon(
                    Iconsax.user,
                    size: AppSize.iconDialogeInfo,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  childField: TextFormFieldWidget(
                    hintText: "32".tr,
                    controller: client!.clientNameController,
                    validator: (value) {
                      if (value.isEmpty || value.toString().trim().isEmpty) {
                        return "28".tr;
                      }

                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),

                SizedBox(height: 10.h),

                RowFieldIcon(
                  childPrefix:
                      Icon(Iconsax.call_add, size: AppSize.iconDialogeInfo),
                  childField: TextFormFieldWidget(
                    hintText: "33".tr,
                    maxLinth: 15,
                    keyboardType: TextInputType.phone,
                    controller: client!.clientPhoneController,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                RowFieldIcon(
                  childPrefix:
                      Icon(Iconsax.location, size: AppSize.iconDialogeInfo),
                  childField: TextFormFieldWidget(
                    hintText: "34".tr,
                    keyboardType: TextInputType.text,
                    controller: client!.clientAddressController,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  trackpadScrollCausesScale: true,
                  child: RowFieldIcon(
                    childPrefix: Icon(Iconsax.calendar_edit,
                        size: AppSize.iconDialogeInfo),
                    childField: GetBuilder<ClientController>(
                      builder: (_controller) => GestureDetector(
                        onTap: () {
                          _controller.getDataTimerCelunder(context);
                        },
                        child: AbsorbPointer(
                          child: DataField(
                            controller: _controller.dateTimeController,

                            // initialValue: "${controller.clientDate}"
                            //     "${controller.clientTime}",
                            // readOnly: true,

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
                SizedBox(height: 10.h),
                RowFieldIcon(
                  childPrefix: Icon(Iconsax.dollar_square,
                      size: AppSize.iconDialogeInfo),
                  childField:
                      //  Obx(
                      //   ()
                      GetBuilder<ClientController>(
                    builder: (controller) => client!.st
                        ? DropDownField(
                            initCurrncyCode:
                                //  index!.value,
                                initVal!.obs,
                            items: client!.crncList)
                        : CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        GetBuilder<ClientController>(
          builder: (controll) => MatrialBottonW(
            minWidth: double.maxFinite,
            text: "29".tr,
            colorBackRound: AppColor.backgroundButton,
            colorText: Colors.white,
            paddHorizontal: 80.w,
            vertical: 8.h,
            onPressed: () async {
              await controll.addNewClient(
                context,
              );
              //hear i editeing

              // client!.refresh();
              Get.back();
              // controll.cleareControllers();
            },
          ),
        )
      ],
    );
  }
}

