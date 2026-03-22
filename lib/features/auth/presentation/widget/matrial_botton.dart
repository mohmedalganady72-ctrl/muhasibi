import 'package:ccount/core/constant/app_size.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatrialBottonW extends StatelessWidget {
  Color? colorBackRound;
  Color? colorText;
  String? text;
  double? minWidth;

  double? paddHorizontal;
  double? vertical;
  void Function()? onPressed;
  bool? enableFeedback;
  MatrialBottonW(
      {super.key,
      required this.text,
      this.colorBackRound,
      this.colorText,
      this.enableFeedback = true,
      required this.onPressed,
      required this.paddHorizontal,
      required this.vertical,
      this.minWidth});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // enableFeedback: enableFeedback!,

      // disabledColor: enableFeedback == false ? Colors.grey : null,
      minWidth: minWidth,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: enableFeedback == false
          ? Color.fromARGB(255, 167, 160, 160)
          : colorBackRound,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: vertical!.h, horizontal: paddHorizontal!.w),
        child: Text(text!,
            style: TextStyle(
                fontSize: AppSize.textBottonSize,
                color: colorText ?? Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
