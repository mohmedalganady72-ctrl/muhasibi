import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

dynamic showSnakBarMassageSecc(BuildContext context, String massag) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color(0xFF54A983),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      content: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: Colors.white,
            size: 25.sp,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Text(
            "$massag",
            style: TextStyleTheme.bottonTextStyl,
          ),
        ],
      ),
    ),
  );
}

dynamic showSnakBarMassageError(BuildContext context, String massag) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Iconsax.close_circle,
            color: Colors.white,
            size: 25.sp,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(massag, style: TextStyleTheme.bottonTextStyl),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF8E1010),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );

  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     backgroundColor: Color(0xFF8E1010),
  //     behavior: SnackBarBehavior.floating,
  //     // animation: CurvedAnimation(
  //     //     parent: AnimationController(
  //     //       vsync: Navigator.of(context),
  //     //       duration: Duration(milliseconds: 300),
  //     //     ),
  //     //     curve: Curves.easeInOutCirc),
  //     content: Row(
  //       children: [
  //         Icon(
  //           Iconsax.close_circle,
  //           color: Colors.white,
  //           size: 25.sp,
  //         ),
  //         SizedBox(
  //           width: 10.sp,
  //         ),
  //         Text(
  //           "$massag",
  //           style: TextStyleTheme.bottonTextStyl,
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
