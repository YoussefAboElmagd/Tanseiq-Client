import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class SelectRentailRegion extends StatelessWidget {
  const SelectRentailRegion({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.text,
  });
  final int index;
  final int currentIndex;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color:
              currentIndex == index
                  ? ColorsManager.mainColor
                  : ColorsManager.grey,
          width: 1.w,
        ),
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
      child: Text(
        text,
        style:
            currentIndex == index
                ? TextStyles.font16MainColorBoldUnderLine
                : TextStyles.font16Grey,
      ),
    );
  }
}
