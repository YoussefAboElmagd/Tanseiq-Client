import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampProgress extends StatelessWidget {
  const CampProgress({super.key, required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 5.h,
            barRadius: Radius.circular(10.r),
            percent: progress / 100,
            backgroundColor: ColorsManager.grey.withOpacity(0.7),
            progressColor: ColorsManager.green,
          ),
        ),
        10.width,
        Text('$progress %', style: TextStyles.font14Black),
      ],
    );
  }
}
