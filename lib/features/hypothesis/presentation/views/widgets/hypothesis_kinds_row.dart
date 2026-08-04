import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class HypothesisKindsRow extends StatelessWidget {
  const HypothesisKindsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.assetsImagesSetting,
          color: ColorsManager.mainColor,
          width: 22.w,
        ),
        10.width,
        Text('انواع الفرضيات', style: TextStyles.font16BlackBold),
      ],
    );
  }
}
