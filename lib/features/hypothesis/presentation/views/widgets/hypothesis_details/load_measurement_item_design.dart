import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class LoadMeasurementItemDesign extends StatelessWidget {
  const LoadMeasurementItemDesign({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.mainColor),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loadTitles[index],
            style: loadStyles[index],
            textAlign: TextAlign.center,
          ),
          Text('2', style: TextStyles.font16Black, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class FiltetRow extends StatelessWidget {
  const FiltetRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20.w,
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
            Assets.assetsImagesFilter,
            width: 22.w,
            height: 22.h,
            color: ColorsManager.mainColor,
          ),
        ),
        Image.asset(Assets.assetsImagesImport, width: 20.w),
      ],
    );
  }
}
