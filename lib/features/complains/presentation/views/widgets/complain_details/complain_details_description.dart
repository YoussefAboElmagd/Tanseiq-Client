import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ComplainDetailsDescription extends StatelessWidget {
  const ComplainDetailsDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.soft2Green),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            offset: Offset(0, 3),
            blurRadius: 1,
          ),
        ],
      ),
      child: Text(description, style: TextStyles.font14BlackBold),
    );
  }
}
