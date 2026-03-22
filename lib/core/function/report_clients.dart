import 'dart:typed_data';
import 'dart:io';
import 'package:ccount/core/constant/app_image.dart';
import 'package:ccount/core/function/pric_formatter.dart';
import 'package:ccount/features/debt/data/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> generateInvoicePdfBytes(
  List<List<dynamic>> itemsData,
  String fromDate,
  String toDate,
  String AddressTow,
  String adressOne,
  String nameCommerss,
  String numFax,
  String numPhon,
  String nameCurrncy,
  String nameReport,
  String pathImageLogo,
  List<String> culomen,
  List<double> culomenWidth,
  num totalAlikom,
  num totalLakom,
  String nameClient,
) async {
// List<double> lis= <double>[0.5,0.2,0.5,0.4];

  final pdf = pw.Document();

  // 1️⃣ تحميل الخط العربي من assets
  final fontData = await rootBundle.load("asset/font/Tajawal-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);
  DateTime now = DateTime.now();

  String date = DateFormat('dd/MM/yyyy').format(now);
  String time = DateFormat('hh:mm a').format(now);

  final baseTextStyle = pw.TextStyle(
    fontSize: 10.sp,
    font: ttf,
  );

  final headerTextStyle = pw.TextStyle(
    fontSize: 14.sp,
    font: ttf,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );

  final companyNameStyle = pw.TextStyle(
    fontSize: 18.sp,
    font: ttf,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );

  // num totalAlikom = 0;
  // num totalLakom = 0;

  final bytes = await rootBundle.load(pathImageLogo);
  final image = pw.MemoryImage(bytes.buffer.asUint8List());
  // final List<String> lsh = ["الصافي", "له", "عليه", "رقم الهاتف", "الاسم"];

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      header: (context) => pw.SizedBox(
        width: 750.w,
        child: pw.Column(children: [
          pw.Container(
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(color: PdfColors.black, width: 3)),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // الجزء العلوي للشركة والشعار
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      width: 200,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("phone:$numPhon"),
                              pw.SizedBox(height: 5.h),
                              pw.Text("fax:$numFax}"),
                            ]),
                      ),
                    ),
                    pw.SizedBox(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Container(
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(100)),
                          child: pw.ClipRRect(
                            child: pw.Image(
                              image,
                              width: 70.w,
                              height: 70.h,
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      width: 200,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text("$nameCommerss",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    font: ttf, fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 5.h),
                            pw.Text("$adressOne",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    font: ttf, fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 5.h),
                            pw.Text("$AddressTow",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    font: ttf, fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10.h),
                pw.Text(
                  "$nameReport",
                  style: headerTextStyle,
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 10.h),
              ],
            ),
          ),
          pw.SizedBox(height: 5.h),
          pw.SizedBox(
            height: 35.h,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "العمله : ${nameCurrncy} ",
                  style: headerTextStyle,
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.SizedBox(height: 5.h),
                      pw.Text(
                        "من تاريخ : ${fromDate} الى تاريخ : ${toDate}",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 13.sp),
                      ),
                      pw.SizedBox(height: 5.h),
                      pw.Text(
                        "${nameClient}",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: ttf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10.sp),
                      ),
                    ]),
              ],
            ),
          ),
        ]),
      ),
      footer: (context) => pw.Container(
        width: double.infinity,
        decoration: pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(color: PdfColors.black))),
        alignment: pw.Alignment.center,
        padding: pw.EdgeInsets.only(top: 5),
        margin: const pw.EdgeInsets.only(top: 10),
        child: pw.Row(
            // crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "صفحة ${context.pageNumber} من ${context.pagesCount}",
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(fontSize: 12, font: ttf),
              ),

              pw.Spacer(),
              pw.Text(
                "تاريخ الطباعه :  ${date} ${time} ",
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(fontSize: 10.sp, font: ttf),
              ),

              // pw.Text(
              //   "تاريخ الطباعه :  ${date} ${time} ",
              //   textDirection: pw.TextDirection.rtl,
              //   style: pw.TextStyle(fontSize: 10.sp, font: ttf),
              // ),
              // pw.SizedBox(width: 20.w),
            ]),
      ),
      build: (context) => [
        pw.SizedBox(height: 5.h),

        pw.Table.fromTextArray(
          columnWidths:
              // columnWidths.map((key, value) =>  key: value,),

              {
            4: pw.FractionColumnWidth(culomenWidth[0]),
            3: pw.FractionColumnWidth(culomenWidth[1]),
            2: pw.FractionColumnWidth(culomenWidth[2]),
            1: pw.FractionColumnWidth(culomenWidth[3]),
            0: pw.FractionColumnWidth(culomenWidth[4]),
          },

          cellAlignment: pw.Alignment.centerRight,
          cellPadding: pw.EdgeInsets.all(5),
          headers: culomen
              .map((e) => pw.Text(
                    e,
                    textDirection: pw.TextDirection.rtl,
                    style: headerTextStyle,
                  ))
              .toList(),
          data: itemsData
              .map((row) => row
                  .map((cell) => pw.Text(
                        cell.toString(),
                        textDirection: pw.TextDirection.rtl,
                        style: baseTextStyle,
                      ))
                  .toList())
              .toList(),
          headerDecoration: pw.BoxDecoration(color: PdfColors.blue100),
          headerCount: 1, // تكرار الصف الأول في كل صفحة
        ),

        // pw.SizedBox(height: 8.h),
        // جدول الإجماليات
        pw.Table(
            border: pw.TableBorder.symmetric(
                outside: pw.BorderSide(color: PdfColors.black)),
            columnWidths: {
              4: pw.FractionColumnWidth(0.30),
              3: pw.FractionColumnWidth(0.20),
              2: pw.FractionColumnWidth(0.1666),
              1: pw.FractionColumnWidth(0.1666),
              0: pw.FractionColumnWidth(0.1666),
            },
            children: [
              pw.TableRow(children: [
                pw.Container(
                    padding: pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            right: pw.BorderSide(
                                color: PdfColors.black, width: 1.5))),
                    child: pw.Text(
                        "${chaongToPricFormatter((totalLakom - totalAlikom).toString())}",
                        textDirection: pw.TextDirection.rtl,
                        style: headerTextStyle)),
                pw.Container(
                    padding: pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            right: pw.BorderSide(
                                color: PdfColors.black, width: 1.5))),
                    child: pw.Text(
                      " ${chaongToPricFormatter((totalLakom ?? 0).abs().toString())}",
                      style: headerTextStyle,
                      textDirection: pw.TextDirection.rtl,
                    )),
                pw.Container(
                    padding: pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            right: pw.BorderSide(
                                color: PdfColors.black, width: 1.5))),
                    child: pw.Text(
                      // "${totalAlikom}",
                      " ${chaongToPricFormatter((totalAlikom ?? 0).abs().toString())}",
                      style: headerTextStyle,
                      textDirection: pw.TextDirection.rtl,
                    )),
                pw.Container(),
                pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Text("الاجمالي :",
                        style: headerTextStyle,
                        textDirection: pw.TextDirection.rtl)),
              ]),
            ]),
        pw.SizedBox(height: 8.h),
        pw.Align(
          alignment: pw.Alignment.bottomRight,
          child: pw.Text(
            "ملاحظه : يعتمد هاذا الكشف صحيحا مالم يتم المراجعه خلال شهر من تاريخ اسنلامه",
            style: pw.TextStyle(font: ttf),
            textDirection: pw.TextDirection.rtl,
          ),
        ),
      ],
    ),
  );

  return Uint8List.fromList(await pdf.save());
}

