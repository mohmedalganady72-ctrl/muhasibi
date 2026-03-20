// import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';

// amontFormatter(TextEditingValue valueControl, String value) {
//   String intPart = value;
//   String decimalPart = "";

//   if (value.contains(".")) {
//     intPart = value.split(".")[0];
//     decimalPart = value.split(".")[1];
//   }

//   if (value.isNotEmpty) {
//     intPart = intPart.replaceAll(",", "");
//     final formatter = NumberFormat("#,##0", "en_US");
//     intPart = formatter.format(int.parse(intPart) ?? 0);
//     String newVal = decimalPart.isNotEmpty
//         ? "$intPart.${decimalPart.substring(0, decimalPart.length.clamp(0, 2))}"
//         : intPart;
//     valueControl = TextEditingValue(
//         text: newVal,
//         selection: TextSelection.collapsed(offset: newVal.length));
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

amontFormatter(TextEditingController controller, String value) {
  String newVal = chaongToPricFormatter(value);

  controller.value = TextEditingValue(
    text: newVal,
    selection: TextSelection.collapsed(offset: newVal.length),
  );
}

chaongToPricFormatter(String value) {
  String intPart = value;
  String decimalPart = "";

  if (value.contains(".")) {
    intPart = value.split(".")[0];
    decimalPart = value.split(".")[1];
  }

  if (value.isNotEmpty) {
    intPart = intPart.replaceAll(",", "");
    final formatter = NumberFormat("#,##0", "en_US");
    intPart = formatter.format(int.tryParse(intPart) ?? 0);

    String newVal = decimalPart.isNotEmpty
        ? "$intPart.${decimalPart.substring(0, decimalPart.length.clamp(0, 2))}"
        : intPart;

    return newVal;
  }
}
