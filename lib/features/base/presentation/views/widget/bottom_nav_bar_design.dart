import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class BottomNavBarItemDesign extends StatelessWidget {
  const BottomNavBarItemDesign({
    super.key,
    required this.index,
    required this.currentIndex,
  });
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Image.asset(
            imagesBottomNavBar[index],
            width: 25.w,
            height: 25.h,
            color:
                currentIndex == index
                    ? ColorsManager.mainColor
                    : ColorsManager.darkGrey,
          ),
        ),
        currentIndex == index
            ? Expanded(
              flex: 2,
              child: Text(names[index], style: TextStyles.font14MainColorBold),
            )
            : const SizedBox.shrink(),
        currentIndex == index
            ? Container(
              width: 50.w,
              height: 3.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: ColorsManager.mainColor,
              ),
            )
            : const SizedBox.shrink(),
      ],
    );
  }
}
