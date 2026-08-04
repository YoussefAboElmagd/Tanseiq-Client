import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    super.key,
    required this.selectedItem,
    required this.index,
  });
  final int selectedItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color:
            selectedItem == index
                ? ColorsManager.mainColor
                : ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  selectedItem == index
                      ? ColorsManager.white
                      : ColorsManager.mainColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              drawerIcons[index],
              width: 20.w,
              height: 20.h,
              color:
                  selectedItem == index
                      ? ColorsManager.mainColor
                      : ColorsManager.white,
            ),
          ),
          10.width,
          Text(
            drawerTitles[index],
            style:
                selectedItem == index
                    ? TextStyles.font16WhiteBold
                    : TextStyles.font16BlackBold,
          ),
        ],
      ),
    );
  }
}
