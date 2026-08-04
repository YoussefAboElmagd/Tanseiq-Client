import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class MonitoringItemDesign extends StatelessWidget {
  const MonitoringItemDesign({
    super.key,
    required this.color,
    required this.image,
    required this.title,
    required this.textStyle,
    required this.quantity,
  });
  final Color color;
  final String image;
  final String title;
  final String quantity;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Image.asset(image, width: 20.w, height: 20.h),
          ),
          10.width,
          Text(title, style: textStyle),
          const Spacer(),
          Text(quantity, style: TextStyles.font16DarkGrey),
        ],
      ),
    );
  }
}
