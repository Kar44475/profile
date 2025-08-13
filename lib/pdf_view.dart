import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

/// Only import dart:html on web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViews extends StatelessWidget {
  const PdfViews({super.key});

  Future<void> _downloadPdfWeb() async {
    final bytes = await rootBundle.load('assets/karthikresume.pdf');
    final blob = html.Blob([bytes.buffer.asUint8List()]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'karthik_resume.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        actions: [
          if (kIsWeb)
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: _downloadPdfWeb,
              tooltip: 'Download PDF',
            ),
        ],
      ),
            body: SfPdfViewer.asset(
              'assets/karthikresume.pdf'));
    
  }
}