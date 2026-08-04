import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class QuantityFilterRow extends StatelessWidget {
  const QuantityFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Text('حصر الكميات', style: TextStyles.font16BlackBold),
        const Spacer(),
        Image.asset(Assets.assetsImagesExport, width: 20.w),
        Image.asset(Assets.assetsImagesImport, width: 20.w),
        Container(
          width: 30.w,
          height: 30.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.soft3Grey,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(Assets.assetsImagesFilter, width: 23.w),
        ),
      ],
    );
  }
}
