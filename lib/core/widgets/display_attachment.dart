import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';

class DisplayAttachment extends StatelessWidget {
  const DisplayAttachment({
    super.key,
    required this.attachmentPath,
    required this.extention,
  });
  final String attachmentPath;
  final String extention;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        title: Text('تفاصيل المرفق', style: TextStyles.font18MainColorBold),
      ),
      body:
          extention == 'pdf'
              ? SfPdfViewer.file(File(attachmentPath))
              : extention == 'jpg' || extention == 'png' || extention == 'jpeg'
              ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image(
                      image: FileImage(File(attachmentPath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              : const EmptyList(text: 'المرفق غير مدعوم'),
    );
  }
}
