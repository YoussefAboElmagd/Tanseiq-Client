import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';

class AddNewSurveyFieldsButtonDesign extends StatelessWidget {
  const AddNewSurveyFieldsButtonDesign({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        border: Border.all(color: ColorsManager.green),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Image.asset(image, width: 25.w),
    );
  }
}
