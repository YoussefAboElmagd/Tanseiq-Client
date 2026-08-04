import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampName extends StatelessWidget {
  const CampName({super.key, required this.campArea, required this.zone});
  final int campArea;
  final String zone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('منطقة $campArea', style: TextStyles.font14BlackBold),
        Container(
          alignment: Alignment.center,
          width: 70.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: ColorsManager.softGreen,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(zone, style: TextStyles.font12GreenBold),
        ),
      ],
    );
  }
}
