// import 'package:ccount/controller/client-controller.dart';
// import 'package:ccount/controller/page-client-controller.dart';
// import 'package:ccount/core/constant/app-color.dart';
// import 'package:ccount/core/services/service.dart';
// import 'package:ccount/core/shared/container-icon.dart';
// import 'package:ccount/core/shared/text-form-filed.dart';
// import 'package:ccount/core/theme/themeMode/Text-style.dart';

// import 'package:ccount/data/model/dbModel/box-model.dart';
// import 'package:ccount/view/debt/client/view/page-client-transaction.dart';
// import 'package:ccount/view/debt/client/widget/list-view-builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:iconsax/iconsax.dart';

// class BuildWidgetPage extends StatelessWidget {
//   String? currncyCode;
//   // BoxModel

//   BuildWidgetPage({super.key, this.currncyCode});

//   @override
//   Widget build(BuildContext context) {
//     PageClientControlle ctrl = Get.put(PageClientControlle());
//     // Get.find<PageClientControlle>();

//     return Scaffold(
//       body: GetBuilder<PageClientControlle>(
//         builder: (controllerPage) => !controllerPage.state
//             ? Text("aliii")
//             : NestedScrollView(
//                 scrollDirection: Axis.vertical,
//                 headerSliverBuilder: (context, innerBoxIsScrolled) {
//                   return [
//                     SliverToBoxAdapter(
//                       child: Container(
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Theme.of(context).brightness == Brightness.dark
//                               ?
//                               //  Colors.blue
//                               AppColor.prymary1
//                               : Colors.white,
//                           border: Border.all(
//                               color: AppColor.backgroundIcon,
//                               width: 2,
//                               style: BorderStyle.solid),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Upon you",
//                                         style: TextStyleTheme.heading2,
//                                       ),
//                                       GetBuilder<PageClientControlle>(
//                                         builder: (controller) {
//                                           return controller.isSelected
//                                               ? Text(
//                                                   "************* ${controller.boxM[currncyCode]!.currncy}",
//                                                   style:
//                                                       TextStyleTheme.priceStyle(
//                                                           AppColor.plusColor))
//                                               : Text(
//                                                   "${controller.boxM[currncyCode]!.currncy}"
//                                                   " "
//                                                   "${controller.boxM[currncyCode]!.alihe}",
//                                                   style:
//                                                       TextStyleTheme.priceStyle(
//                                                           AppColor.plusColor),
//                                                 );
//                                         },
//                                         // ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 5.h,
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "your",
//                                         style: TextStyleTheme.heading2,
//                                       ),
//                                       GetBuilder<PageClientControlle>(
//                                           builder: (controlle) {
//                                         return controlle.isSelected
//                                             ? Text(
//                                                 "************* ${controlle.boxM[currncyCode]!.currncy}",
//                                                 style:
//                                                     TextStyleTheme.priceStyle(
//                                                         AppColor.minusColor))
//                                             : Text(
//                                                 "${controlle.boxM[currncyCode]!.currncy}"
//                                                 " "
//                                                 "${controlle.boxM[currncyCode]!.laho}",
//                                                 style:
//                                                     TextStyleTheme.priceStyle(
//                                                         AppColor.minusColor),
//                                               );
//                                       }),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 5.h,
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Total",
//                                         style: TextStyleTheme.heading2,
//                                       ),
//                                       GetBuilder<PageClientControlle>(
//                                           builder: (_controller) {
//                                         return _controller.isSelected
//                                             ? Text(
//                                                 "************* ${_controller.boxM[currncyCode]!.currncy}",
//                                                 style:
//                                                     TextStyleTheme.priceStyle(
//                                                         AppColor.starColor))

//                                             /*
// Text(
//   "${_controller.boxM![currncyCode]!.currncy}"
//   "${(_controller.boxM![currncyCode]!.alihe! - _controller.boxM![currncyCode]!.laho!).toStringAsFixed(2)}",
// )

//                                                         */
//                                             : Text(
//                                                 "${_controller.boxM[currncyCode]!.currncy}"
//                                                 " "
//                                                 "${(_controller.boxM[currncyCode]!.alihe! - _controller.boxM[currncyCode]!.laho!).toStringAsFixed(2)}",
//                                                 style: (_controller
//                                                                 .boxM[
//                                                                     currncyCode]!
//                                                                 .alihe! -
//                                                             _controller
//                                                                 .boxM[
//                                                                     currncyCode]!
//                                                                 .laho! <
//                                                         0)
//                                                     ? TextStyleTheme.Total(
//                                                         AppColor.minusColor,
//                                                       )
//                                                     : TextStyleTheme.Total(
//                                                         AppColor.plusColor),
//                                               );
//                                       }),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 8.h,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     GestureDetector(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Icon(
//                                           Iconsax.user,
//                                           size: 25.sp,
//                                           color:
//                                               //  AppColor.Selected
//                                               AppColor.prymary1,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 3.h,
//                                     ),
//                                     GetBuilder<PageClientControlle>(
//                                       builder: (_controllerPade) => _controllerPade
//                                                       .MapClientByCurrncy[
//                                                   currncyCode] ==
//                                               null
//                                           ? Text("0")
//                                           : Text(
//                                               "${_controllerPade.MapClientByCurrncy[currncyCode]!.length}",
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: AppColor.prymary1
//                                                   // AppColor.Selected),
//                                                   )),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 46.h,
//                                 ),
//                                 GetBuilder<PageClientControlle>(
//                                     builder: (controller) {
//                                   return GestureDetector(
//                                     onTap: () => controller.changeSelected(),
//                                     child: Icon(
//                                         controller.isSelected
//                                             ? Iconsax.eye_slash
//                                             : Iconsax.eye,
//                                         size: 25.sp,
//                                         color:
//                                             //  AppColor.Selected,
//                                             AppColor.prymary1),
//                                   );
//                                 }),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: SizedBox(
//                         height: 5.h,
//                       ),
//                     ),
//                     SliverAppBar(
//                       backgroundColor: Colors.white,
//                       surfaceTintColor: Colors.transparent,
//                       automaticallyImplyLeading: false,
//                       title: TextFormFieldWidget(
//                         prefixIcon: const Icon(
//                           Iconsax.search_normal,
//                           color: AppColor.maybe,
//                           fill: 0.2,
//                         ),
//                         hintText: "serch",
//                         keyboardType: TextInputType.text,
//                         controller: TextEditingController(),
//                         validator: (value) => null,
//                       ),
//                       floating: false,
//                       pinned: true,
//                       actions: [
//                         GestureDetector(
//                           child: ContainerIcon(
//                             child: const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(Iconsax.sort,
//                                   size: 30,
//                                   color:
//                                       //
//                                       // AppColor.Selected,
//                                       AppColor.prymary1),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         GestureDetector(
//                           child: ContainerIcon(
//                             child: const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(Iconsax.folder,
//                                   size: 30, color: AppColor.prymary1
//                                   // AppColor.Selected,
//                                   ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                       ],
//                     ),
//                   ];
//                 },
//                 body: GetBuilder<PageClientControlle>(builder: (_controller) {
//                   if (_controller.MapClientByCurrncy[currncyCode]!.isEmpty) {
//                     // if (_controller.clientList.isEmpty) {
//                     return Center(child: Text("No clients found"));
//                   } else {
//                     return Padding(
//                       padding: EdgeInsets.only(top: 8),
//                       child: ListView.builder(
//                         itemCount:
//                             _controller.MapClientByCurrncy[currncyCode]!.length,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               Get.to(PageClientTransaction(),
//                                   arguments: _controller
//                                       .MapClientByCurrncy[currncyCode]![index]);
//                             },
//                             child: Card(
//                               elevation: 0,
//                               color: Colors.white,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   side: BorderSide(
//                                       color: AppColor.borderCard,
//                                       width: 1,
//                                       strokeAlign: 5)),
//                               child: ListTile(
//                                 leading: ContainerIcon(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 15.sp, vertical: 10.sp),
//                                     child: Text(
//                                       "${_controller.MapClientByCurrncy[currncyCode]![index].name}"
//                                           .substring(0, 1),
//                                       style: TextStyle(
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   '${_controller.MapClientByCurrncy[currncyCode]![index].name}',
//                                   style: TextStyle(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 subtitle: Text(
//                                   '${_controller.MapClientByCurrncy[currncyCode]![index].receivables} ${_controller.MapClientByCurrncy[currncyCode]![index].currncy}',
//                                   style: TextStyle(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: AppColor.plusColor),
//                                 ),
//                                 trailing: ContainerIcon(
//                                   child: Padding(
//                                     padding: EdgeInsets.all(8),
//                                     child: Text(
//                                         "${_controller.MapClientByCurrncy[currncyCode]![index].id}"),
//                                     // "${_controller.clientList[index].id}"),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 }),
//               ),
//       ),
//     );
//   }
// }
