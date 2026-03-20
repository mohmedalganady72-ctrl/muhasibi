import 'package:ccount/core/constant/app-color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerIcon extends StatelessWidget {
  Widget? child;
  Color? colorBackground;
  Color? colorBorder;
  double? wigthBorder;
  BoxConstraints? constraints;
  ContainerIcon(
      {super.key,
      required this.child,
      this.colorBackground,
      this.colorBorder,
      wigthBorder,
      this.constraints});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : colorBackground ?? AppColor.backgroundIcon,
        border: Border.all(
            color: colorBorder ?? Colors.transparent,
            width: wigthBorder ?? 0.5.w),
      ),
      child: child,
    );
  }
}
