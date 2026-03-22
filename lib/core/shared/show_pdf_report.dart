import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Uint8List pdfBytes;
  const PdfPreviewPage({super.key, required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("معاينة الفاتورة")),
      body: PdfPreview(
        // actionBarTheme: PdfActionBarTheme(),

        build: (format) => pdfBytes,
        pdfFileName: "report-hesabat.pdf",
        // canChangePageFormat: true,
        // dynamicLayout: true,
        allowPrinting: true,
        allowSharing: true,
      ),
    );
  }
}
