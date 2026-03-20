import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/function/date-time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DataField extends StatelessWidget {
  final String? label;
  TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  Widget? prefixIcon;
  bool? readOnly;
  bool? edit;
  Color? color;

  // String? initialValue;
  final String? Function(dynamic value) validator;

  DataField({
    super.key,
    this.prefixIcon,
    this.label,
    this.hintText,
    this.keyboardType,
    this.controller,
    required this.validator,
    this.readOnly = false,
    this.color,
    this.edit = false,
    // this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      // initialValue: initialValue,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: edit! ? Colors.grey : Colors.black),
      readOnly: readOnly!,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        // prefixText: " ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        prefixIcon: prefixIcon,
        // disabledBorder: InputBorder.none,
        filled: true,
        // disabledBorder: InputBorder.none,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.filledColorDark
            : color,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        label: label != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    child: Text(
                  label!,
                )),
              )
            : null,
        alignLabelWithHint: false,
      ),
    );
  }
}
