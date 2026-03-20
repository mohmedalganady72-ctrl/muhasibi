import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleTheme {
  static TextStyle heading = TextStyle(
    fontSize: AppSize.headingSize,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading1 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle lables = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle heading2 = TextStyle(
    fontSize: AppSize.heading2Size,
    fontWeight: FontWeight.w400,
  );
  static TextStyle dontFound = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey);
  static TextStyle foundData = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle subheading = TextStyle(
    fontSize: AppSize.subheadingSize,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bottonTextStyl = TextStyle(
      fontSize: AppSize.textBottonSize,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  static TextStyle bottonTextStylLink = TextStyle(
      fontSize: AppSize.textBottonSize,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle hintFiled = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 65, 135, 192));

  static TextStyle caption = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 7, 81, 167));
  static TextStyle captionNormal = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 7, 81, 167));

  static TextStyle priceStyle(Color? color) {
    return TextStyle(
        fontWeight: FontWeight.w600, fontSize: AppSize.priceSize, color: color);
  }

  static TextStyle Total(Color? color) {
    return TextStyle(
        fontWeight: FontWeight.w700, fontSize: AppSize.TotalSize, color: color);
  }

  static TextStyle bottomNavBar(Color? color) {
    return TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: color);
  }
}
