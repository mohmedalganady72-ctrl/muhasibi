import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconPAdding extends StatelessWidget {
  IconData? icon;
  IconPAdding({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        size: 40.sp,
        icon,
        color: Colors.black,
      ),
    );
  }
}
