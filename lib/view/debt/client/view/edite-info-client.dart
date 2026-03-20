import 'package:ccount/controller/edite-cinfo-client-controller.dart';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/app-size.dart';

import 'package:ccount/core/shared/row-filde-icon.dart';
import 'package:ccount/core/shared/text-form-filed.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';
import 'package:ccount/view/debt/client/view/page-client-transaction.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class EditeInfoClient extends StatelessWidget {
  EditeInfoClient({
    super.key,
  });

  EditInfoClientController editeClientcontroller =
      Get.put(EditInfoClientController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                editeClientcontroller.goToTransactionClient();
              },
              icon: Icon(Iconsax.arrow_left))
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("37".tr),
        toolbarHeight: 35.h,
        surfaceTintColor: const Color.fromARGB(31, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: SizedBox(
          width: double.maxFinite,
          // height: 250.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: Stack(
                      children: [
                        GetBuilder<EditInfoClientController>(
                          builder: (control) => Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(
                                color: control.pathImageClient ==
                                        AppImage.userProfile
                                    ? Colors.transparent
                                    : AppColor.IconButton,
                                width: 4,
                              ),
                            ),
                            child:
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(1000),
                                //   child: control.pathImageClient ==
                                //           AppImage.userProfile
                                //       ? Image.asset(
                                //           AppImage.userProfile,
                                //           width: 130.w,
                                //         )
                                //       : Image(
                                //           image: ResizeImage(
                                //             width: (130.w).toInt(),
                                //             height: (130.h).toInt(),
                                //             FileImage(
                                //               control.fileProfileImageClient!,
                                //             ),
                                //           ),
                                //           fit: BoxFit.cover,
                                //         ),
                                // ),
                                CircleAvatar(
                              radius: 65.w, // نصف العرض
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: control.pathImageClient ==
                                      AppImage.userProfile
                                  ? AssetImage(AppImage.userProfile)
                                      as ImageProvider
                                  : FileImage(control.fileProfileImageClient!),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100.h,
                          right: 0.w,
                          child: InkWell(
                            onTap: () {
                              editeClientcontroller.getPicker(context);
                            },
                            child: GetBuilder<EditInfoClientController>(
                              builder: (controller) => ClipRRect(
                                borderRadius: BorderRadius.circular(500),
                                child: Container(
                                    width: 35.w,
                                    height: 35.h,
                                    color: controller.pathImageClient ==
                                            AppImage.userProfile
                                        ? Colors.black
                                        : AppColor.IconButton,
                                    child: controller.pathImageClient ==
                                            AppImage.userProfile
                                        ? const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Form(
                    key: editeClientcontroller.formKeyEditClient,
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
                          childField: GetBuilder<EditInfoClientController>(
                            builder: (_controller) => TextFormFieldWidget(
                              suffixIcon: _controller.errorIcon,
                              onChanged: (val) {
                                if (val.isEmpty ||
                                    val.toString().trim().isEmpty) {
                                  _controller.setErrorIcon();
                                } else {
                                  _controller.setErrorIconTrue();
                                }
                                if (editeClientcontroller.isChanged != true) {
                                  _controller.changeT();
                                }
                              },
                              hintText: "32".tr,
                              controller:
                                  editeClientcontroller.nameClientController,

                              // validator: (value) {
                              //   if (value.isEmpty ||
                              //       value.toString().trim().isEmpty) {
                              //     return "28".tr;
                              //   }

                              //   return null;
                              // },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        RowFieldIcon(
                          childPrefix: Icon(Iconsax.call_add,
                              size: AppSize.iconDialogeInfo),
                          childField: TextFormFieldWidget(
                            onChanged: (val) {
                              if (editeClientcontroller.isChanged != true) {
                                editeClientcontroller.changeT();
                              }
                            },
                            hintText: "33".tr,
                            maxLinth: 15,
                            keyboardType: TextInputType.phone,
                            controller:
                                editeClientcontroller.phoneClientController,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        RowFieldIcon(
                          childPrefix: Icon(Iconsax.location,
                              size: AppSize.iconDialogeInfo),
                          childField: TextFormFieldWidget(
                            onChanged: (val) {
                              if (editeClientcontroller.isChanged != true) {
                                editeClientcontroller.changeT();
                              }
                            },
                            hintText: "34".tr,
                            keyboardType: TextInputType.text,
                            controller:
                                editeClientcontroller.locationClientController,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GetBuilder<EditInfoClientController>(
                    builder: (controll) => AbsorbPointer(
                      absorbing: !controll.isChanged,
                      child: GestureDetector(
                        onTap: () async {
                          await controll.formValidateUpdated(
                            context,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          constraints: BoxConstraints(
                            minWidth: double.maxFinite,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.backgroundButton,
                          ),
                          child: Text(
                            "29".tr,
                            style: TextStyleTheme.bottonTextStyl,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
