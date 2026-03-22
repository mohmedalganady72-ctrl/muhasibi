import 'package:ccount/core/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FloatingButton extends StatelessWidget {
  final String label;
  void Function()? onTap;
  IconData? icon;
  MainAxisAlignment? mainAxisAlignment;
  Color? colorIcon;
  Color? colorback;
  Color? colorText;
  int sizeIcon;
  double? radios;
  double? hortin;
  double? virtecl;

  FloatingButton(
      {super.key,
      required this.label,
      this.icon,
      required this.onTap,
      this.sizeIcon = 20,
      this.colorIcon,
      this.colorback,
      this.colorText,
      this.mainAxisAlignment,
      this.radios,
      this.hortin,
      this.virtecl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
          // height: 35.h,
          // width: 85.w,
          constraints: BoxConstraints(
              minHeight: virtecl ?? 70.h, maxWidth: hortin ?? 120.w),
          decoration: BoxDecoration(
            // border: Border.all(),
            border:
                Border.all(color: colorIcon ?? AppColor.IconButton, width: 2),
            color: colorback ?? AppColor.backgroundButton,
            // AppColor.praimaryColor,
            borderRadius: BorderRadius.circular(radios ?? 10),
          ),
          // child: Center(
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: sizeIcon.sp,
                color: colorIcon ?? Colors.white,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colorText ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
