import 'dart:ffi';

import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  Widget? prefixIcon;
  bool? readOnly;
  int? maxLinth;
  int? maxLine;
  Widget? suffixIcon;
  final String? Function(dynamic value)? validator;
  bool? edit;

  TextFormFieldWidget({
    super.key,
    this.suffixIcon,
    this.maxLine,
    this.maxLinth,
    this.prefixIcon,
    this.onChanged,
    this.label,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.readOnly = false,
    this.edit = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: initialValue,

      readOnly: readOnly!,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLinth ?? 100,
      maxLines: maxLine ?? 1,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: edit! ? Colors.grey[500] : Colors.black),
      decoration: InputDecoration(
        // prefixText: " ",
        suffixIcon: suffixIcon,
        counterText: "",

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: TextStyleTheme.hintFiled,
        prefixIcon: prefixIcon,

        filled: true,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.filledColorDark
            : AppColor.filleTextFiled,
        // : AppColor.filledColorLight,
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        // border: OutlineInputBorder(
        //     borderSide:
        //         BorderSide(color: Color.fromARGB(255, 75, 41, 41), width: 0),
        //     borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
