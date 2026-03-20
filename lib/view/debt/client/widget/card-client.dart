import 'dart:io';

import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-image.dart';
import 'package:ccount/core/function/pric-formatter.dart';
import 'package:ccount/core/shared/container-icon.dart';
import 'package:ccount/data/model/dbModel/customer-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CardClient extends StatelessWidget {
//   CustomerModel? client;
//   void Function()? onTap;
//   CardClient({super.key, this.client, this.onTap});

//   @override
Card CardClient(CustomerModel? client) {
  return Card(
    elevation: 0,
    child: ListTile(
      leading: SizedBox(
        width: 48.w,
        height: 48.h,
        child: Container(
            padding: const EdgeInsets.all(2),
            constraints: BoxConstraints(minHeight: 90.h, minWidth: 90.w),
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: client!.pathImageProfile == AppImage.userProfile
                    ? Colors.blue.shade100
                    : AppColor.IconButton,
                width: 1,
              ),
              color: client.pathImageProfile == AppImage.userProfile
                  ? AppColor.backgroundIcon
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(1000),
            ),
            child:
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(1000),
                //   child: client.pathImageProfile == AppImage.userProfile
                //       ? Center(
                //           child: Text(
                //             "${client.name!.substring(0, 1)}",
                //             textAlign: TextAlign.center,
                //             // style:
                //             //     TextStyleTheme.body,
                //             style: TextStyle(
                //               fontSize: 20.sp,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         )
                //       : Image(
                //           image: ResizeImage(
                //             width: (100.w).toInt(),
                //             height: (100.h).toInt(),
                //             FileImage(
                //               File(client.pathImageProfile!),
                //             ),
                //           ),
                //           fit: BoxFit.cover,
                //         ),
                // ),
                // CircleAvatar(
                //   radius: 65.w, // نصف العرض
                //   backgroundColor: Colors.grey.shade200,

                //       child: client.pathImageProfile == AppImage.userProfile
                //                   ? Center(
                //           child: Text(
                //             "${client.name!.substring(0, 1)}",
                //             textAlign: TextAlign.center,
                //             // style:
                //             //     TextStyleTheme.body,
                //             style: TextStyle(
                //               fontSize: 20.sp,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         )
                //           : FileImage(client.pathImageProfile!),
                // ),
                CircleAvatar(
              radius: 65.w, // نصف القطر
              backgroundColor: AppColor.filleTextFiled,

              // في حال يوجد صورة من المستخدم
              backgroundImage: client.pathImageProfile != AppImage.userProfile
                  ? FileImage(File(client.pathImageProfile!))
                  : null,

              // في حال لا يوجد صورة نعرض أول حرف من الاسم
              child: client.pathImageProfile == AppImage.userProfile
                  ? Center(
                      child: Text(
                        client.name != null && client.name!.isNotEmpty
                            ? client.name!.substring(0, 1).toUpperCase()
                            : "?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  : null,
            )),
      ),
      // ),
      title: Text(
        '${client.name}',
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${chaongToPricFormatter(((client.lakom!) - (client.alikom!)).abs().toString())} ${client.currncy}',
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          color: ((client.lakom!) - (client.alikom!)) >= 0
              ? AppColor.plusColor
              : AppColor.minusColor,
        ),
      ),
      trailing: SizedBox(
        width: 33.w,
        height: 30.h,
        child: ContainerIcon(
          constraints: BoxConstraints(minHeight: 33.h, minWidth: 30.w),
          child: Center(
            child: Text(
              "${client.numberTrans}",
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.IconButton),
            ),
          ),
        ),
      ),
      // ),
    ),
  );
}
// }
