import 'package:ccount/core/shared/container_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowFieldIcon extends StatelessWidget {
  final Widget childField;
  final Widget? childPrefix;
  final double horizontalPadding;
  final double verticalPadding;
  Color? color;

  RowFieldIcon(
      {super.key,
      this.color,
      required this.childField,
      this.childPrefix,
      this.horizontalPadding = 9.0,
      this.verticalPadding = 9.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerIcon(
            colorBackground: color,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: childPrefix,
            )),
        SizedBox(width: 8.w),
        Expanded(child: childField),
      ],
    );
  }
}
