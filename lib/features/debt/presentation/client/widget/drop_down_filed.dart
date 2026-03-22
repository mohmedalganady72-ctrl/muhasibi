import 'package:ccount/features/debt/presentation/controllers/client_controller.dart';

import 'package:ccount/core/constant/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class DropDownField extends StatelessWidget {
  List<String>? items;
  // RxString controller;
  RxString initCurrncyCode;

  DropDownField({
    super.key,
    required this.items,
    // required this.controller,
    required this.initCurrncyCode,
  });

  @override
  Widget build(BuildContext context) {
    // NewClientAddController control = Get.find<NewClientAddController>();
    return GetBuilder<ClientController>(
      builder: (control) => DropdownButtonFormField2<String>(
        // barrierColor: AppColor.IconButton,
        // barrierLabel: ",am",
        // dropdownSearchData: DropdownSearchData()
        // ,
        // style: TextField.materialMisspelledTextStyle,

        isExpanded: true,
        value: initCurrncyCode.value,
        decoration: InputDecoration(
          filled: true,

          // disabledBorder: InputBorder.none,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? AppColor.filledColorDark
              : AppColor.filledColorLight,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          alignLabelWithHint: false,
        ),
        items: items!
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select gender.';
          }
          control.selectrtCurrncy = value.obs;
          return null;
        },
        onChanged: (value) {
          //Do something when selected it
          //em is changed.
          if (value != null) {
            control.selectrtCurrncy = value.obs;
          }
        },
        onSaved: (value) {
          // selectedValue = value.toString();
          if (value != null) {
            control.selectrtCurrncy = value.obs;
          }
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),

        dropdownStyleData: DropdownStyleData(
          scrollbarTheme: ScrollbarThemeData(
            // trackColor: AppColor.Selected,
            thumbColor: MaterialStateProperty.all(AppColor.prymary1),
            radius: Radius.circular(10),
            // interactive: true
          ),
          // offset: Offset.zero,
          maxHeight: 150.h,
          // elevation: 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

