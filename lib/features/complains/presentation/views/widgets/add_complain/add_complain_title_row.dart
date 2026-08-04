import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class AddComplainTitleRow extends StatelessWidget {
  const AddComplainTitleRow({super.key});

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
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.soft3Grey,
                offset: Offset(0, 3),
                blurRadius: 1,
              ),
            ],
          ),
          child: Image.asset(
            Assets.assetsImagesDoc,
            width: 20.w,
            height: 20.h,
            color: ColorsManager.mainColor,
          ),
        ),
        10.width,
        Text('ابلاغ عن مشكلة', style: TextStyles.font16BlackBold),
      ],
    );
  }
}
