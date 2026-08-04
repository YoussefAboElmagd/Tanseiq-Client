import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

SnackBar customSnackBar({required String message, Color? color}) => SnackBar(
  backgroundColor: color ?? ColorsManager.red,
  behavior: SnackBarBehavior.floating,
  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
  showCloseIcon: true,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  content: Text(message, style: TextStyles.font16WhiteBold),
  elevation: 10,
  duration: const Duration(milliseconds: 900),
);
