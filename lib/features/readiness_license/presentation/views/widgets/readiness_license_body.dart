import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ReadinessLicenseBody extends StatelessWidget {
  ReadinessLicenseBody({super.key});

  final List<String> mainText = [
    'مساحة الخيام',
    'الفئة',
    'الجنسية',
    'رقم طلب الاضافات',
    'عدد الخيام',
    'رقم الطلب',
    'رقم الطلب في كدانة',
    'رقم المخيم',
    'شركة الخدمة',
    'عدد الحجاج',
  ];
  final List<String> secondText = [
    '123م',
    'فئة1',
    'مصري',
    '123',
    '123',
    '123',
    '123',
    '123',
    'كدانة',
    '123',
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              Row(
                spacing: 10.w,
                children: [
                  Image.asset(
                    Assets.assetsImagesSettings,
                    width: 30.w,
                    height: 30.h,
                  ),
                  Text('رخصة الجاهزية', style: TextStyles.font16BlackBold),
                ],
              ),
              Divider(color: ColorsManager.mainColor.withOpacity(.3)),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LicenseItem(
                    mainText: mainText[index],
                    secondText: secondText[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.height;
                },
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LicenseItem extends StatelessWidget {
  const LicenseItem({super.key, this.mainText, this.secondText});

  final String? mainText;
  final String? secondText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorsManager.green2.withOpacity(.3),
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(mainText!, style: TextStyles.font14MainColorBold),
            Text(secondText!, style: TextStyles.font14BlackBold),
          ],
        ),
      ),
    );
  }
}
