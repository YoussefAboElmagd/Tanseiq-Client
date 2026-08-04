import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class DrawerProfileButton extends StatelessWidget {
  const DrawerProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: ColorsManager.soft3Grey,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            Assets.assetsImagesProfile,
            width: 25.w,
            height: 25.h,
            color: ColorsManager.grey,
          ),
        ),
        10.width,
        Text('محمد احمد', style: TextStyles.font16BlackBold),
      ],
    );
  }
}
