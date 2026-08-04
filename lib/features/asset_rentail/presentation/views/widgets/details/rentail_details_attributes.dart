import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class RentailDetailsAttributes extends StatelessWidget {
  const RentailDetailsAttributes({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 27.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color:
            index % 2 == 0
                ? ColorsManager.soft2MainColor
                : ColorsManager.soft2Grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rentailDetailsTitles[index], style: TextStyles.font12BlackBold),
          Text('2', style: TextStyles.font12BlackBold),
        ],
      ),
    );
  }
}
