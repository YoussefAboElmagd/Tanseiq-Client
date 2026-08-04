import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ComplainDetailsTitleRow extends StatelessWidget {
  const ComplainDetailsTitleRow({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.soft3Grey,
                offset: Offset(0, 3),
                blurRadius: 1,
              ),
            ],
          ),
          child: Image.asset(
            Assets.assetsImagesQuestions,
            width: 22.w,
            height: 22.h,
            color: ColorsManager.mainColor,
          ),
        ),
        10.width,
        Text('نوع المشكلة $title', style: TextStyles.font16BlackBold),
      ],
    );
  }
}
