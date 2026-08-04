import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_text_style.dart';
import 'package:tanseiq/features/asset_rentail/data/models/get_all_assets_response.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/status_row.dart';

class RentailItemDesign extends StatelessWidget {
  const RentailItemDesign({
    super.key,
    required this.isRejected,
    required this.data,
  });
  final bool isRejected;
  final GetAllAssetsResponseData data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      // height: 160.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          StatusRow(
            state: data.statusAcception ?? 'غير محدد',
            requestNumber:
                data.orderNumber == null
                    ? 'غير محدد'
                    : data.orderNumber.toString(),
            isRejected: isRejected,
          ),
          const Divider(color: ColorsManager.soft3Grey),
          CustomTextStyle(
            style1: TextStyles.font14BlackBold,
            style2: TextStyles.font14MainColorBold,
            text1: 'الشركة المؤجرة : ',
            text2: data.company ?? 'غير محدد',
          ),
          CustomTextStyle(
            style1: TextStyles.font14BlackBold,
            style2: TextStyles.font14MainColorBold,
            text1: 'الشركة المطورة : ',
            text2: data.developCompany ?? 'غير محدد',
          ),
        ],
      ),
    );
  }
}
