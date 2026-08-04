import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.color,
    this.textStyle,
    this.borderRadius,
    this.borderColor,
  });
  final String title;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Function() onTap;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: color ?? ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        ),
        child: Text(title, style: textStyle ?? TextStyles.font20WhiteBold),
      ),
    );
  }
}
