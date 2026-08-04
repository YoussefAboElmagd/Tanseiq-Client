import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class PrepareOrAllWorkChangeItem extends StatelessWidget {
  const PrepareOrAllWorkChangeItem({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 35.h,
              decoration: BoxDecoration(
                color:
                    currentIndex == 0
                        ? ColorsManager.mainColor
                        : ColorsManager.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'اعمال تجهيز الخيام',
                style:
                    currentIndex == 0
                        ? TextStyles.font14WhiteBold
                        : TextStyles.font14BlackBold,
              ),
            ),
          ),
          10.width,
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 35.h,
              decoration: BoxDecoration(
                color:
                    currentIndex == 1
                        ? ColorsManager.mainColor
                        : ColorsManager.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'اعمال تشيد الخيام',
                style:
                    currentIndex == 1
                        ? TextStyles.font14WhiteBold
                        : TextStyles.font14BlackBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
