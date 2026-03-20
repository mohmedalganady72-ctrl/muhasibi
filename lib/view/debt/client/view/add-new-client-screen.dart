// import 'package:ccount/controller/client-controller.dart';

// import 'package:ccount/core/constant/app-color.dart';
// import 'package:ccount/core/constant/app-image.dart';
// import 'package:ccount/core/constant/app-size.dart';
// import 'package:ccount/core/function/date-time.dart';
// import 'package:ccount/core/shared/data-file.dart';
// import 'package:ccount/core/shared/phone-filed.dart';
// import 'package:ccount/core/shared/row-filde-icon.dart';
// import 'package:ccount/core/shared/text-form-filed.dart';
// import 'package:ccount/core/theme/themeMode/Text-style.dart';

// import 'package:ccount/data/model/dbModel/currency-model.dart';
// import 'package:ccount/test/table-tast.dart';
// import 'package:ccount/view/auth/widget/matrial-botton.dart';
// import 'package:ccount/view/debt/client/view/client-screen.dart';
// import 'package:ccount/view/debt/client/view/currncy-screen.dart';
// import 'package:ccount/view/debt/client/view/load-contact-screen.dart';
// import 'package:ccount/view/debt/client/widget/drop-down-filed.dart';
// import 'package:ccount/view/home/view/home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/instance_manager.dart';
// import 'package:iconsax/iconsax.dart';

// class AddNewClientScreen extends StatelessWidget {
//   void Function()? onTapViewPaktecher;
//   Key? keyForm;
//   TextEditingController? controllerName;
//   TextEditingController? controllerPhne;
//   TextEditingController? controllerAddress;
//   bool? stState;

//   AddNewClientScreen({
//     super.key,
//   });

//   // ClientController clientContollere = Get.find<ClientController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.off(Home(),
//                     transition: Transition.leftToRight,
//                     duration: Duration(milliseconds: 300));
//               },
//               icon: Icon(Iconsax.back_square))
//         ],
//         scrolledUnderElevation: 0,
//         title: Text("52".tr),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//         child: SizedBox(
//           width: double.maxFinite,
//           // height: 250.h,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Container(
//                     child: Stack(
//                       children: [
//                         GetBuilder<ClientController>(
//                           builder: (control) => Container(
//                               padding: const EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(1000),
//                                 border: Border.all(
//                                   color:
//                                       control.pathImageProfileController.text ==
//                                               AppImage.userProfile
//                                           ? Colors.transparent
//                                           : AppColor.IconButton,
//                                   width: 4,
//                                 ),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(1000),
//                                 child:
//                                     control.pathImageProfileController.text ==
//                                             AppImage.userProfile
//                                         ? Image.asset(
//                                             AppImage.userProfile,
//                                             width: 130.w,
//                                           )
//                                         : Image(
//                                             image: ResizeImage(
//                                               width: (130.w).toInt(),
//                                               height: (130.h).toInt(),
//                                               FileImage(
//                                                 control.fileProfileImageClient!,
//                                               ),
//                                             ),
//                                             fit: BoxFit.cover,
//                                           ),
//                               )),
//                         ),
//                         Positioned(
//                           top: 100.h,
//                           right: 0.w,
//                           child: InkWell(
//                             onTap: onTapViewPaktecher,
//                             // () {
//                               // clientContollere.getPicker(context);

//                             // },
//                             child: GetBuilder<ClientController>(
//                               builder: (controller) => ClipRRect(
//                                 borderRadius: BorderRadius.circular(500),
//                                 child: Container(
//                                     width: 35.w,
//                                     height: 35.h,
//                                     color: controller.pathImageProfileController
//                                                 .text ==
//                                             AppImage.userProfile
//                                         ? Colors.black
//                                         : AppColor.IconButton,
//                                     child: controller.pathImageProfileController
//                                                 .text ==
//                                             AppImage.userProfile
//                                         ? const Icon(
//                                             Icons.add_a_photo,
//                                             color: Colors.white,
//                                           )
//                                         : const Icon(
//                                             Icons.edit,
//                                             color: Colors.white,
//                                           )),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Form(
//                     key: keyForm,
//                     child: Column(
//                       // mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Container(child: const Icon(Iconsax.user)),

//                         RowFieldIcon(
//                           childPrefix: Icon(
//                             Iconsax.user,
//                             size: AppSize.iconDialogeInfo,
//                             color: Theme.of(context).iconTheme.color,
//                           ),
//                           childField: TextFormFieldWidget(
//                             hintText: "32".tr,
//                             controller: controllerName,
//                             validator: (value) {
//                               if (value.isEmpty ||
//                                   value.toString().trim().isEmpty) {
//                                 return "28".tr;
//                               }

//                               return null;
//                             },
//                             keyboardType: TextInputType.name,
//                           ),
//                         ),

//                         SizedBox(height: 10.h),

//                         RowFieldIcon(
//                           childPrefix: Icon(Iconsax.call_add,
//                               size: AppSize.iconDialogeInfo),
//                           childField: TextFormFieldWidget(
//                             hintText: "33".tr,
//                             maxLinth: 15,
//                             keyboardType: TextInputType.phone,
//                             controller: controllerPhne,
//                             validator: (value) {
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         RowFieldIcon(
//                           childPrefix: Icon(Iconsax.location,
//                               size: AppSize.iconDialogeInfo),
//                           childField: TextFormFieldWidget(
//                             hintText: "34".tr,
//                             keyboardType: TextInputType.text,
//                             controller:
//                                controllerAddress,
//                             validator: (value) {
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         GestureDetector(
//                           trackpadScrollCausesScale: true,
//                           child: RowFieldIcon(
//                             childPrefix: Icon(Iconsax.calendar_edit,
//                                 size: AppSize.iconDialogeInfo),
//                             childField: GetBuilder<ClientController>(
//                               builder: (_controller) => GestureDetector(
//                                 onTap: () {
//                                   _controller.getDataTimerCelunder(context);
//                                 },
//                                 child: AbsorbPointer(
//                                   child: DataField(
//                                     color: AppColor.filleTextFiled,
//                                     controller: _controller.dateTimeController,

//                                     // initialValue: "${controller.clientDate}"
//                                     //     "${controller.clientTime}",
//                                     // readOnly: true,

//                                     keyboardType: TextInputType.datetime,
//                                     // controller: TextEditingController(),
//                                     validator: (value) {
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         RowFieldIcon(
//                           childPrefix: Icon(Iconsax.dollar_square,
//                               size: AppSize.iconDialogeInfo),
//                           childField:
//                               //  Obx(
//                               //   ()
//                             //   GetBuilder<ClientController>(
//                             // builder: (controller) =>
//                             stState!
//                                 ?
//                                      GetBuilder<ClientController>(
//                             builder: (controller) =>
//                                 DropDownField(
//                                     initCurrncyCode:
//                                         //  index!.value,
//                                         controller
//                                             .crncList[controller.selectee].obs,
//                                     items: controller.crncList))
//                                 : CircularProgressIndicator(),
//                           ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   GetBuilder<ClientController>(
//                     builder: (controll) => GestureDetector(
//                       onTap: () async {
//                         await controll.addNewClient(
//                           context,
//                         );
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.symmetric(vertical: 10.h),
//                         constraints: BoxConstraints(
//                           minWidth: double.maxFinite,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: AppColor.backgroundButton,
//                         ),
//                         child: Text(
//                           "29".tr,
//                           style: TextStyleTheme.bottonTextStyl,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Text("51".tr,
//                       style: TextStyle(
//                           fontSize: AppSize.textBottonSize,
//                           fontWeight: FontWeight.bold)),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   GetBuilder<ClientController>(
//                     builder: (_controller) => GestureDetector(
//                       onTap: () async {
//                         await _controller.loadContacts();

//                         Get.to(LoadContactScreen());
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.symmetric(vertical: 8.h),
//                         constraints: BoxConstraints(
//                           minWidth: double.maxFinite,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _controller.stateContact
//                                 ? Text(
//                                     "53".tr,
//                                     style: TextStyle(
//                                         fontSize: AppSize.textBottonSize,
//                                         color: AppColor.IconButton,
//                                         fontWeight: FontWeight.bold),
//                                   )
//                                 : Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                             SizedBox(
//                               width: 5.w,
//                             ),
//                             Icon(Iconsax.call_add),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ccount/controller/client-controller.dart';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/constant/app-size.dart';
import 'package:ccount/core/function/date-time.dart';
import 'package:ccount/core/shared/data-file.dart';
import 'package:ccount/core/shared/phone-filed.dart';
import 'package:ccount/core/shared/row-filde-icon.dart';
import 'package:ccount/core/shared/text-form-filed.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';

import 'package:ccount/data/model/dbModel/currency-model.dart';
import 'package:ccount/test/table-tast.dart';
import 'package:ccount/view/auth/widget/matrial-botton.dart';
import 'package:ccount/view/debt/client/view/client-screen.dart';
import 'package:ccount/view/debt/client/view/currncy-screen.dart';
import 'package:ccount/view/debt/client/view/load-contact-screen.dart';
import 'package:ccount/view/debt/client/widget/drop-down-filed.dart';
import 'package:ccount/view/home/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';

class AddNewClientScreen extends StatelessWidget {
  AddNewClientScreen({
    super.key,
  });

  ClientController clientContollere = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.off(() => Home(),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));
              },
              icon: Icon(Iconsax.arrow_left))
        ],
        scrolledUnderElevation: 0,
        title: Text("52".tr),
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
                        GetBuilder<ClientController>(
                          builder: (control) => Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(
                                color:
                                    control.pathImageProfileController.text ==
                                            AppImage.userProfile
                                        ? Colors.transparent
                                        : AppColor.IconButton,
                                width: 4,
                              ),
                            ),

                            child: CircleAvatar(
                              radius: 65.w, // نصف العرض
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: control
                                          .pathImageProfileController.text ==
                                      AppImage.userProfile
                                  ? AssetImage(AppImage.userProfile)
                                      as ImageProvider
                                  : FileImage(control.fileProfileImageClient!),
                            ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(1000),
                            //   child: control.pathImageProfileController.text ==
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
                          ),
                        ),
                        Positioned(
                          top: 100.h,
                          right: 0.w,
                          child: InkWell(
                            onTap: () {
                              clientContollere.getPicker(context);
                            },
                            child: GetBuilder<ClientController>(
                              builder: (controller) => ClipRRect(
                                borderRadius: BorderRadius.circular(500),
                                child: Container(
                                    width: 35.w,
                                    height: 35.h,
                                    color: controller.pathImageProfileController
                                                .text ==
                                            AppImage.userProfile
                                        ? Colors.black
                                        : AppColor.IconButton,
                                    child: controller.pathImageProfileController
                                                .text ==
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
                    key: clientContollere.formNewClient,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // Container(child: const Icon(Iconsax.user)),

                        GetBuilder<ClientController>(
                          builder: (_controllerr) => RowFieldIcon(
                            childPrefix: Icon(
                              Iconsax.user,
                              size: AppSize.iconDialogeInfo,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            childField: TextFormFieldWidget(
                              hintText: "32".tr,
                              suffixIcon: _controllerr.iconErorr,
                              controller: _controllerr.clientNameController,

                              onChanged: (valeu) {
                                if (valeu.isEmpty ||
                                    valeu.toString().trim().isEmpty) {
                                  _controllerr.setIconWorning();
                                } else {
                                  _controllerr.setIconWorningTrue();
                                }
                              },

                              // validator: (value) {
                              //   if (value.isEmpty ||
                              //       value.toString().trim().isEmpty) {
                              //     return clientContollere.setIconWorning();
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
                            hintText: "33".tr,
                            maxLinth: 15,
                            keyboardType: TextInputType.phone,
                            controller: clientContollere.clientPhoneController,
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
                            hintText: "34".tr,
                            keyboardType: TextInputType.text,
                            controller:
                                clientContollere.clientAddressController,
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
                                    color: AppColor.filleTextFiled,
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
                            builder: (controller) => clientContollere.st
                                ? DropDownField(
                                    initCurrncyCode:
                                        //  index!.value,
                                        controller
                                            .crncList[controller.selectee].obs,
                                    items: controller.crncList)
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GetBuilder<ClientController>(
                    builder: (controll) => GestureDetector(
                      onTap: () async {
                        await controll.addNewClient(
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
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("51".tr,
                      style: TextStyle(
                          fontSize: AppSize.textBottonSize,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5.h,
                  ),
                  GetBuilder<ClientController>(
                    builder: (_controller) => GestureDetector(
                      onTap: () async {
                        await _controller.loadContacts();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        constraints: BoxConstraints(
                          minWidth: double.maxFinite,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _controller.stateContact
                                ? Text(
                                    "53".tr,
                                    style: TextStyle(
                                        fontSize: AppSize.textBottonSize,
                                        color: AppColor.IconButton,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(Iconsax.call_add),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
