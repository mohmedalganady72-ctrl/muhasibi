import 'package:ccount/features/debt/presentation/client/view/client_screen.dart';
import 'package:ccount/features/debt/presentation/view/suplier_screent.dart';
import 'package:ccount/features/settings/presentation/view/more_screen.dart';
import 'package:ccount/features/debt/presentation/supplier/view/supplier_screen.dart';
import 'package:flutter/material.dart';

List<Widget> buildFooterButtons = [
  // const DebtMain(),

  ClientScreen(),
  const SupplierScreen(),
  const MoreScreen(),
];

