import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ComplainDetailsItemDesign extends StatelessWidget {
  const ComplainDetailsItemDesign({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      width: double.infinity,
      alignment: Alignment.centerRight,
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
      child: Row(
        spacing: 20.w,
        children: [
          Expanded(child: Text(text1, style: TextStyles.font14MainColorBold)),
          Expanded(
            flex: 2,
            child: Text(text2, style: TextStyles.font14SoftBlack),
          ),
        ],
      ),
    );
  }
}
