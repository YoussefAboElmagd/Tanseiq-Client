import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class EmptySurvey extends StatelessWidget {
  const EmptySurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        border: Border.all(color: ColorsManager.mainColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.assetsImagesCodiconEmptyWindow,
            height: 80.h,
            width: 80.w,
          ),
          10.height,
          Text('شاشة الاستبيانات فارغة', style: TextStyles.font22MainColorBold),
          10.height,
          Text(
            textAlign: TextAlign.center,
            'مرحبًا بك في قسم الاستبيانات! حاليًا، شاشة الاستبيانات فارغة ولا تحتوي على أي استمارة. لإضافة حقول جديدة، يُرجى اتباع الخطوات التالية:',
            style: TextStyles.font14SoftBlackBold,
          ),
          10.height,
          Row(
            children: [
              CircleAvatar(radius: 2.r, backgroundColor: ColorsManager.black),
              5.width,
              Text('إضافة حقول جديدة:', style: TextStyles.font14BlackBold),
            ],
          ),
          5.height,
          Expanded(
            child: Text(
              textAlign: TextAlign.start,
              'انقر على زر "إضافة حقل" الموجود في الجزء العلوي من الشاشة.اختر نوع الحقل الذي ترغب في إضافته (مثل نص، اختيار من متعدد، إلخ) دخل المعلومات اللازمة مثل العنوان والوصف',
              style: TextStyles.font10SoftBlack,
            ),
          ),
          10.height,
          Row(
            children: [
              CircleAvatar(radius: 2.r, backgroundColor: ColorsManager.green),
              5.width,
              Text('تعديل الحقول', style: TextStyles.font14GreenBold),
            ],
          ),
          5.height,
          Expanded(
            child: Text(
              textAlign: TextAlign.start,
              'إذا كنت ترغب في تعديل حقل موجود، انقر على الثلاث نقاط بجوار الحقل الذي تريد تعديله.قم بإجراء التغييرات المطلوبة، ثم احفظ التعديلات.',
              style: TextStyles.font10SoftBlack,
            ),
          ),
          10.height,
          Row(
            children: [
              CircleAvatar(radius: 2.r, backgroundColor: ColorsManager.darkRed),
              5.width,
              Text('حذف الحقول', style: TextStyles.font14DarkRedBold),
            ],
          ),
          5.height,
          Expanded(
            child: Text(
              textAlign: TextAlign.start,
              'لحذف حقل، انقر على حذف من القائمة المنسدلة بجوار الحقل المراد حذفه.تأكد من أنك ترغب في حذف الحقل قبل تأكيد العملية.',
              style: TextStyles.font10SoftBlack,
            ),
          ),
        ],
      ),
    );
  }
}
