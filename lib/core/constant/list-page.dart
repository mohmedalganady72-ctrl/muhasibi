import 'package:ccount/view/debt/client/view/client-screen.dart';
import 'package:ccount/view/debt/view/suplier-screent.dart';
import 'package:ccount/view/setting/view/more-screen.dart';
import 'package:ccount/view/debt/supplier/view/supplier-screen.dart';
import 'package:flutter/material.dart';

List<Widget> buildFooterButtons = [
  // const DebtMain(),

  ClientScreen(),
  const SupplierScreen(),
  const MoreScreen(),
];
