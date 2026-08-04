import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/accept_reject_attributes_item_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/pdf_button_design.dart';

class AttributesPdfButton extends StatelessWidget {
  const AttributesPdfButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: ColorsManager.soft3Grey,
            blurRadius: 1,
            offset: Offset(3, 0),
          ),
        ],
      ),
      child: Column(
        spacing: 10.h,
        children: const [
          AcceptRejectAttributesItemDesign(text1: 'رقم الطلب', text2: '123'),
          AcceptRejectAttributesItemDesign(
            text1: 'شركة المؤجرة',
            text2: 'شركة 1',
          ),
          AcceptRejectAttributesItemDesign(
            text1: 'الشركة المطورة',
            text2: 'شركة 1',
          ),
          PdfButtonDesign(title: 'تعهدpdf'),
        ],
      ),
    );
  }
}
