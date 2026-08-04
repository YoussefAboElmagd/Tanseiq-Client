import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampStatus extends StatelessWidget {
  const CampStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 35.h,
      decoration: BoxDecoration(
        color:
            status.contains('جارى العمل')
                ? ColorsManager.softYellow
                : ColorsManager.softGreen,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        status,
        style:
            status.contains('جارى العمل')
                ? TextStyles.font16YellowBold
                : TextStyles.font16GreenBold,
      ),
    );
  }
}
