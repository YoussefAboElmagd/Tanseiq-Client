import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampTags extends StatelessWidget {
  const CampTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.softBurbel,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('مكيف', style: TextStyles.font12BurbelBold),
          ),
        ),
        10.width,
        Expanded(
          child: Container(
            height: 25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.softGreen,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('ماء', style: TextStyles.font12GreenBold),
          ),
        ),
        10.width,
        Expanded(
          child: Container(
            height: 25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.softYellow,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('كهرباء', style: TextStyles.font12YellowBold),
          ),
        ),
      ],
    );
  }
}
