import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/alert_design.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_text_style.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_map_points.dart';

class MarkerDetailsAlert extends StatelessWidget {
  const MarkerDetailsAlert({super.key, required this.point});
  final GetMapPoints point;

  @override
  Widget build(BuildContext context) {
    return AlertDesign(
      title: Text('تفاصيل الموقع', style: TextStyles.font16MainColorBold),
      content: SizedBox(
        height: 230.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'رقم المحول: ',
              text2: point.serialNumber ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'الشركة المطورة: ',
              text2: point.developerCompany ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'الشركة الخدمة: ',
              text2: point.serviceCompany ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'تاريخ الانشاء: ',
              text2: point.createDate ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'المنطقة: ',
              text2: point.zone ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'خط العرض: ',
              text2: point.latitude ?? 'غير محدد',
            ),
            CustomTextStyle(
              style1: TextStyles.font14BlackBold,
              style2: TextStyles.font14GreenBold,
              text1: 'خط الطول: ',
              text2: point.longitude ?? 'غير محدد',
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: CustomButton(
            height: 40.h,
            width: 150.w,
            title: 'رجوع',
            color: ColorsManager.red,
            textStyle: TextStyles.font14WhiteBold,
            borderRadius: 16.r,
            onTap: () {
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
