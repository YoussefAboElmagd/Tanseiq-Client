import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: ''),
      body: SfPdfViewer.file(File(path)),
    );
  }
}
