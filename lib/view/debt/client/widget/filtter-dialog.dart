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
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class FilterDialog extends StatelessWidget {
  // String? initVal;
  GetxController? client;

  List<CustomerModel>? dataClient;
  String? currncyName;

  FilterDialog({super.key, this.dataClient, this.currncyName});

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
          scrollDirection: Axis.vertical,
          // child: Form(
          //   key: client!.formNewClient,
          child: Container(
            width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "فلترة حسب ",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<ClientController>(
                        builder: (_controller) => Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  groupValue: _controller.vleuGropOrderFilter,
                                  onChanged: (value) {
                                    _controller.changeGrupeFilter(value!);
                                  },
                                  activeColor: AppColor.IconButton,
                                  value: "all",
                                ),
                                SizedBox(width: 60.w, child: Text("الكل")),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColor.IconButton,
                                  groupValue: _controller.vleuGropOrderFilter,
                                  onChanged: (value) {
                                    _controller.changeGrupeFilter(value!);
                                  },
                                  value: "taswia",
                                ),
                                Text("تمت التسوية"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // GetBuilder<ClientController>(
                      //   builder: (_controller) =>

                      // ),
                      // GetBuilder<ClientController>(
                      //   builder: (_controller) => Row(
                      //     children: [
                      //       // SizedBox(
                      //       //     width: 50.w,
                      //       //     child: Text(
                      //       //       "المعاملة : ",
                      //       //       style: TextStyle(fontWeight: FontWeight.bold),
                      //       //     )),
                      //       Row(
                      //         children: [
                      //           Radio(
                      //             groupValue: _controller.vleuGropOrderTrans,
                      //             onChanged: (value) {
                      //               _controller.changeGrupeTrans(value!);
                      //             },
                      //             activeColor: AppColor.IconButton,
                      //             value: "new",
                      //           ),
                      //           SizedBox(width: 40.w, child: Text("الجديده")),
                      //         ],
                      //       ),
                      //       Row(
                      //         children: [
                      //           Radio(
                      //             activeColor: AppColor.IconButton,
                      //             groupValue: _controller.vleuGropOrderTrans,
                      //             onChanged: (value) {
                      //               _controller.changeGrupeTrans(value!);
                      //             },
                      //             value: "old",
                      //           ),
                      //           Text("القديمه"),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///////////////////////////////

                      // GetBuilder<ClientController>(
                      //   builder: (_controller) => Row(
                      //     children: [
                      //       SizedBox(
                      //           width: 50.w,
                      //           child: Text(
                      //             "المبالغ :",
                      //             style: TextStyle(fontWeight: FontWeight.bold),
                      //           )),
                      //       Row(
                      //         children: [
                      //           Radio(
                      //             groupValue: _controller.vleuGropOrderPrice,
                      //             onChanged: (value) {
                      //               _controller.changeGrupePrice(value!);
                      //             },
                      //             activeColor: AppColor.IconButton,
                      //             value: "up",
                      //           ),
                      //           SizedBox(width: 40.w, child: Text("الاعلى")),
                      //         ],
                      //       ),
                      //       Row(
                      //         children: [
                      //           Radio(
                      //             activeColor: AppColor.IconButton,
                      //             groupValue: _controller.vleuGropOrderPrice,
                      //             onChanged: (value) {
                      //               _controller.changeGrupePrice(value!);
                      //             },
                      //             value: "down",
                      //           ),
                      //           Text("الاقل"),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///////////////////////
                      GetBuilder<ClientController>(
                        builder: (_controller) => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  groupValue: _controller.vleuGropOrderFilter,
                                  onChanged: (value) {
                                    _controller.changeGrupeFilter(value!);
                                  },
                                  activeColor: AppColor.IconButton,
                                  value: "lakom",
                                ),
                                SizedBox(width: 60.w, child: Text("لكم")),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColor.IconButton,
                                  groupValue: _controller.vleuGropOrderFilter,
                                  onChanged: (value) {
                                    _controller.changeGrupeFilter(value!);
                                  },
                                  value: "alikom",
                                ),
                                Text("عليكم"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                    _controller.changeGrupeOrder(value!);
                                  },
                                  activeColor: AppColor.IconButton,
                                  value: "old",
                                ),
                                SizedBox(width: 60.w, child: Text(" القديمة")),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColor.IconButton,
                                  groupValue: _controller.vleuGropOrder,
                                  onChanged: (value) {
                                    _controller.changeGrupeOrder(value!);
                                  },
                                  value: "new",
                                ),
                                Text("الجديدة"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ///////////////////////
                      GetBuilder<ClientController>(
                        builder: (_controller) => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  groupValue: _controller.vleuGropOrder,
                                  onChanged: (value) {
                                    _controller.changeGrupeOrder(value!);
                                  },
                                  activeColor: AppColor.IconButton,
                                  value: "down",
                                ),
                                SizedBox(
                                    width: 60.w, child: Text("المبالغ الاقل")),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColor.IconButton,
                                  groupValue: _controller.vleuGropOrder,
                                  onChanged: (value) {
                                    _controller.changeGrupeOrder(value!);
                                  },
                                  value: "up",
                                ),
                                Text("المبالغ الاعلى"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ////////////////////
                SizedBox(height: 10.h),

                // Frome date init Repoort

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
