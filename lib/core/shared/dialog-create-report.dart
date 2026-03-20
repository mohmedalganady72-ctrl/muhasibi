import 'package:ccount/controller/client-controller.dart';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-size.dart';
import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/core/shared/data-file.dart';
import 'package:ccount/core/shared/phone-filed.dart';
import 'package:ccount/core/shared/row-filde-icon.dart';
import 'package:ccount/core/shared/text-form-filed.dart';

import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:ccount/view/auth/widget/matrial-botton.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/widget/drop-down-filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class DialogCreateReport extends StatelessWidget {
  // String? initVal;
  GetxController? client;

  List<CustomerModel>? dataClient;
  String? currncyName;

  DialogCreateReport({super.key, this.dataClient, this.currncyName});

  @override
  Widget build(BuildContext context) {
    // NewClientAddController control = Get.put(NewClientAddController());

    return AlertDialog(
      elevation: 0,
      title: Center(
          child: Text(
        "create report",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      content: SizedBox(
        width: double.maxFinite,
        // height: 250.h,
        child: SingleChildScrollView(
          // child: Form(
          //   key: client!.formNewClient,
          child: Container(
            // width: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.backgroundIcon,
                border: Border.all(
                    width: 1,
                    color: Color.fromARGB(255, 232, 228, 228),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                // Container(child: const Icon(Iconsax.user)),

                SizedBox(height: 10.h),

                // Frome date init Repoort
                GestureDetector(
                  trackpadScrollCausesScale: true,
                  child: RowFieldIcon(
                    color: Colors.transparent,
                    childPrefix: Text(
                      "من تاريخ : ",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    // horizontalPadding: 0,
                    // verticalPadding: 0,
                    childField: GetBuilder<ClientController>(
                      builder: (controller) => GestureDetector(
                        onTap: () {
                          controller.fromDateReport(context);
                        },
                        child: AbsorbPointer(
                          child: DataField(
                            controller: controller.fromDateController,

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
                // To date init Repoort
                GestureDetector(
                  trackpadScrollCausesScale: true,
                  child: RowFieldIcon(
                    color: Colors.transparent,
                    childPrefix: Text(
                      "الى تاريخ : ",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    childField: GetBuilder<ClientController>(
                      builder: (controller) => GestureDetector(
                        onTap: () {
                          controller.toDateReport(context);
                        },
                        child: AbsorbPointer(
                          child: DataField(
                            controller: controller.toDateConstroller,

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
                // RowFieldIcon(
                //   childPrefix: Icon(Iconsax.dollar_square,
                //       size: AppSize.iconDialogeInfo),
                //   childField:
                //       //  Obx(
                //       //   ()
                //       GetBuilder<ClientController>(
                //     builder: (controller) => client!.st
                //         ? DropDownField(
                //             initCurrncyCode:
                //                 //  index!.value,
                //                 initVal!.obs,
                //             items: client!.crncList)
                //         : CircularProgressIndicator(),
                //   ),
                // ),
                Container(
                  // width: 100,
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 189, 186, 186),
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "ترتيب حسب ",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<ClientController>(
                        builder: (_controller) => Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  groupValue: _controller.vleuGropOrder,
                                  onChanged: (value) {
                                    _controller.changeGrupe(value!);
                                  },
                                  activeColor: AppColor.IconButton,
                                  value: "up",
                                ),
                                Text("المبالغ الاعلى"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColor.IconButton,
                                  groupValue: _controller.vleuGropOrder,
                                  onChanged: (value) {
                                    _controller.changeGrupe(value!);
                                  },
                                  value: "down",
                                ),
                                Text("المبالغ الاقل"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GetBuilder<ClientController>(
                            builder: (_controller) => GestureDetector(
                              onTap: () {
                                _controller.changeCheckBoxZero();
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _controller.checkBoxViewZeroReport,
                                    onChanged: (valew) {
                                      _controller.changeCheckBoxZero();
                                    },
                                  ),
                                  Text(
                                    "اظهار الحسابات الصفريه",
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      // ),
      actions: [
        GetBuilder<ClientController>(
            builder: (_controll) =>

                // MatrialBottonW(
                //   minWidth: double.maxFinite,
                //   text: "create",
                //   colorBackRound: AppColor.backgroundButton,
                //   colorText: Colors.white,
                //   // paddHorizontal: 80.w,
                //   // vertical: 8.h,
                //   onPressed: () async {
                //     await controll.exportPdf(context, dataClient!, currncyName!);
                //     Get.back();

                //     // client!.refresh();
                //     // Get.back();
                //     // controll.cleareControllers();
                //   },
                // ),
                AbsorbPointer(
                  absorbing: !_controll.stateReport,
                  child: GestureDetector(
                    onTap: () async {
                      await _controll.exportPdf(
                          context, dataClient!, currncyName!);
                    },
                    child: Container(
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.IconButton,
                        ),
                        child: _controll.stateReport
                            ? Text(
                                "create",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))),
                  ),
                ))
      ],
    );
  }
}
