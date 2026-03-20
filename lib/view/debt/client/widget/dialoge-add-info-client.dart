import 'package:ccount/controller/client-controller.dart';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-size.dart';
import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/core/shared/data-file.dart';
import 'package:ccount/core/shared/phone-filed.dart';
import 'package:ccount/core/shared/row-filde-icon.dart';
import 'package:ccount/core/shared/text-form-filed.dart';

import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:ccount/view/auth/widget/matrial-botton.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/widget/drop-down-filed.dart';
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
