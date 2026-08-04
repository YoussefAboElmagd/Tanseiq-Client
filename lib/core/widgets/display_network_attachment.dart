import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_network_image.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';

class DisplayNetworkAttachment extends StatelessWidget {
  const DisplayNetworkAttachment({
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
              ? SfPdfViewer.network('${ApiConstants.baseUrl}$attachmentPath')
              : extention == 'jpg' || extention == 'png' || extention == 'jpeg'
              ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomNetworkImage(
                      width: double.infinity,
                      height: 400.h,
                      image: attachmentPath,
                    ),
                  ),
                ),
              )
              : const EmptyList(text: 'المرفق غير مدعوم'),
    );
  }
}
