import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<List<int>> generateInvoicePdfBytes() async {
  final pdf = pw.Document();

  final String customerName = "أحمد محمد";
  final String invoiceDate = "2025-09-17";

  final List<Map<String, dynamic>> items = [
    {"name": "منتج A", "quantity": 2, "price": 50.0},
    {"name": "منتج B", "quantity": 1, "price": 70.0},
    {"name": "منتج C", "quantity": 3, "price": 20.0},
  ];

  final List<List<String>> itemRows = items.map((item) {
    final total = item["quantity"] * item["price"];
    return [
      item["name"].toString(),
      item["quantity"].toString(),
      item["price"].toString(),
      total.toString()
    ];
  }).toList();

  final double grandTotal = items.fold(
    0,
    (sum, item) => sum + (item["quantity"] * item["price"]),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        var pw;
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("فاتورة",
                style:
                    pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("العميل: $customerName"),
            pw.Text("التاريخ: $invoiceDate"),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ["العنصر", "الكمية", "السعر", "الإجمالي"],
              data: itemRows,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.center,
              cellStyle: pw.TextStyle(fontSize: 12),
              border: pw.TableBorder.all(color: PdfColors.grey),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text("الإجمالي: \$${grandTotal.toStringAsFixed(2)}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save(); // <-- ترجع الـ PDF كـ List<int>
}
