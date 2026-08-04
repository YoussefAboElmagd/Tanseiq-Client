import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';

class CampDetailsAttributesItemDesign extends StatelessWidget {
  const CampDetailsAttributesItemDesign({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget,
    );
  }
}
