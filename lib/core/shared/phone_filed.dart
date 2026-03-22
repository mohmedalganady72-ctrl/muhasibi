import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/shared/text_form_filed.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;
  String? label;
  void Function(String)? onChanged;
  final String? Function(dynamic) validator;
  PhoneField(
      {super.key,
      this.controller,
      this.onChanged,
      required this.validator,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormFieldWidget(
            onChanged: onChanged,
            maxLinth: 15,
            prefixIcon: const CountryCodePicker(
              backgroundColor: AppColor.praimaryColorBackround,
              onChanged: print,
              dialogSize: Size(50, 500),
              showFlagMain: false,
              initialSelection: '+967',
              favorite: ['+967', 'YE', 'KSA'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              barrierColor: AppColor.praimaryColorBackround,
            ),
            controller: controller,
            keyboardType: TextInputType.phone,
            hintText: "11".tr,
            label: label?.tr,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
