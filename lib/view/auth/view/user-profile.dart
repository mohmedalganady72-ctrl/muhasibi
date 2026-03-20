import 'package:ccount/core/constant/app-page.dart';
import 'package:ccount/core/shared/phone-filed.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ccount/controller/user-profile-controller.dart';
import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/function/validetor.dart';

import 'package:ccount/view/auth/widget/matrial-botton.dart';
import 'package:ccount/core/shared/text-form-filed.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfileController controllerUser = Get.put(UserProfileController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("16".tr),
        toolbarHeight: 35.h,
        surfaceTintColor: const Color.fromARGB(31, 255, 255, 255),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Stack(
                    children: [
                      GetBuilder<UserProfileController>(
                        builder: (control) => Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(
                                color: control.profileImage != null
                                    ? const Color.fromARGB(230, 55, 217, 6)
                                    : Colors.transparent,
                                width: 4,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: control.profileImage == null
                                  ? Image.asset(
                                      AppImage.userProfile,
                                      width: 135.w,
                                    )
                                  : Image.file(
                                      control.profileImage!,
                                      width: 135.w,
                                      height: 135.h,
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                      Positioned(
                        top: 100.h,
                        right: 2.w,
                        child: InkWell(
                          onTap: () {
                            controllerUser.getPicker(context);
                          },
                          child: GetBuilder<UserProfileController>(
                            builder: (controller) => ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: Container(
                                  width: 35.w,
                                  height: 35.h,
                                  color: Colors.black,
                                  child: controller.profileImage == null
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
                  height: 30.h,
                ),
                Column(
                  children: [
                    Form(
                      key: controllerUser.formKey,
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                prefixIcon: const Icon(Icons.person),
                                label: "9".tr,
                                validator: (value) {
                                  return validateName(value);
                                },
                                keyboardType: TextInputType.name,
                                hintText: "12".tr,
                                controller: controllerUser.nameController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                prefixIcon: const Icon(Icons.location_on),
                                keyboardType: TextInputType.streetAddress,
                                hintText: "13".tr,
                                label: "10".tr,
                                controller: controllerUser.locationController,
                                validator: (value) {
                                  return validateLocation(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        PhoneField(
                          controller: controllerUser.phoneController,
                          validator: (value) {
                            return validatePhone(value);
                          },
                          // label: "11".tr,
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 145.w,
                      ),
                      child: MatrialBottonW(
                        vertical: 7.h,
                        paddHorizontal: 40.w,
                        text: "15".tr,
                        onPressed: () {
                          Get.offAllNamed(AppPage.homePage);
                          // controllerUser.formValidate();
                        },
                        colorBackRound: AppColor.praimaryColorGreen,
                        colorText: AppColor.praimaryColorBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
