// import 'package:ccount/core/constant/app-color.dart';
// import 'package:ccount/core/services/service.dart';
// import 'package:ccount/core/shared/container-icon.dart';
// import 'package:ccount/data/data-source/list-clinet.dart';
// import 'package:ccount/features/debt/data/models/customer-model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class ListViewBuilderWidget extends StatelessWidget {
//   // List<CustomerModel> clients;
//   String? currncys;
//   ListViewBuilderWidget({super.key, this.currncys});

//   @override
//   Widget build(BuildContext context) {
//     final clients = MapListClient.mapListClient[currncys]?.toList() ?? [];
//     // final clients = service.mapClient.mapListClient[currncys]?.toList() ?? [];
//     // return Obx(() {
//     return clients.isEmpty
//         ? Center(child: Text("No clients found"))
//         : Padding(
//             padding: EdgeInsets.only(top: 8),
//             child: ListView.builder(
//               itemCount: clients.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {},
//                   child: Card(
//                     // semanticContainer: false,
//                     // surfaceTintColor: const Color.fromARGB(255, 22, 29, 37),
//                     // borderOnForeground: false,
//                     // color: Color.fromARGB(255, 149, 114, 114),
//                     elevation: 0,

//                     color: Colors.white,
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         side: BorderSide(
//                             color: AppColor.borderCard,
//                             width: 1,
//                             strokeAlign: 5)),
//                     // semanticContainer: F,
//                     child: ListTile(
//                       leading: ContainerIcon(
//                           child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 15.sp, vertical: 10.sp),
//                         child: Text(
//                           "N",
//                           style: TextStyle(
//                               fontSize: 12.sp, fontWeight: FontWeight.w600),
//                         ),
//                       )),
//                       title: Text(
//                         '${clients[index].name}',
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       subtitle: 
                      
                      
//                       Text(
//                         '${(clients[index].receivables! - clients[index].payables!).toStringAsFixed(2)}',
//                         style: TextStyle(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w500,
//                             color: (clients[index].receivables! -
//                               clients[index].payables!)>=0 ? AppColor.plusColor:AppColor.minusColor
//                                        ,               
                            
//                              ),
//                       ),
//                       trailing: ContainerIcon(
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text("${clients[index].id}"),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ));
//     // });
//   }
// }

