import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class RowIconData extends StatelessWidget {
  IconData? icon;

  Widget? text;
  RowIconData({super.key, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        //     child:
        Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 25.sp,
          // weight: 30,
        ),
        SizedBox(
          width: 10.w,
        ),
        text!
        // Text(
        //   "$data",
        //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        // ),
      ],
      // )
    );
  }
}
