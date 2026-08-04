// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';

class TextStyles {
  // Main Color
  static TextStyle font12MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14MainColor = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 14.sp,
  );
  static TextStyle font18MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16MainColorBoldUnderLine = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.mainColor,
  );
  static TextStyle font20MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font22MainColorBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.mainColor,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );

  // Grey
  static TextStyle font14GreyUnderLine = TextStyle(
    fontSize: 14.sp,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.grey,
    color: ColorsManager.grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font16Grey = TextStyle(
    fontSize: 16.sp,
    color: const Color.fromARGB(255, 192, 192, 192),
    fontFamily: 'Almarai',
  );
  static TextStyle font16SoftGrey3 = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.soft3Grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font14SoftGrey3 = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.soft3Grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font12Grey = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.soft4Grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font14Grey = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.soft4Grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font14NormalGrey = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font12NormalGrey = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.grey,
    fontFamily: 'Almarai',
  );
  static TextStyle font16DarkGrey = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.darkGrey,
    fontFamily: 'Almarai',
  );
  static TextStyle font18DarkGrey = TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.darkGrey,
    fontFamily: 'Almarai',
  );
  static TextStyle font14DarkGrey = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.darkGrey,
    fontFamily: 'Almarai',
  );
  static TextStyle font12DarkGrey = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.darkGrey,
    fontFamily: 'Almarai',
  );

  // Black
  static TextStyle font18BlackBold = TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16BlackBold = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16Black = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
  );
  static TextStyle font14BlackBold = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font12BlackBold = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font10BlackBold = TextStyle(
    fontSize: 10.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font12SoftBlack = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
  );
  static TextStyle font14Black = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
  );
  static TextStyle font16SoftBlackBold = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font20SoftBlackBold = TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14SoftBlackBold = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14SoftBlack = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
  );
  static TextStyle font16SoftBlack = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
  );
  static TextStyle font10SoftBlack = TextStyle(
    fontSize: 10.sp,
    color: ColorsManager.softBlack,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font11Grey = TextStyle(
    fontSize: 11.sp,
    color: ColorsManager.grey,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font10Black = TextStyle(
    fontSize: 10.sp,
    color: ColorsManager.black,
    fontFamily: 'Almarai',
  );

  // White
  static TextStyle font25WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font20WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font18White = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 18.sp,
  );
  static TextStyle font14WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font12WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font15White = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 15.sp,
  );
  static TextStyle font10WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.white,
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
  );

  // Red
  static TextStyle font10Red = TextStyle(
    fontSize: 10.sp,
    color: ColorsManager.darkRed,
    fontFamily: 'Almarai',
  );
  static TextStyle font12Red = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.darkRed,
    fontFamily: 'Almarai',
  );
  static TextStyle font14DarkRedBold = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.darkRed,
    fontFamily: 'Almarai',
  );
  static TextStyle font18DarkRedBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.darkRed,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16DarkRedBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.darkRed,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16RedBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.red,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14RedBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.red,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  // Green
  static TextStyle font12GreenUnderLine = TextStyle(
    fontSize: 12.sp,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.green,
    color: ColorsManager.green,
    fontFamily: 'Almarai',
  );
  static TextStyle font14GreenUnderLine = TextStyle(
    fontSize: 14.sp,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.green,
    color: ColorsManager.green,
    fontFamily: 'Almarai',
  );
  static TextStyle font16GreenUnderLine = TextStyle(
    fontSize: 16.sp,
    decoration: TextDecoration.underline,
    decorationColor: ColorsManager.green,
    color: ColorsManager.green,
    fontFamily: 'Almarai',
  );
  static TextStyle font18GreenBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.green,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16GreenBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.green,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14GreenBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.green,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14Green = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.green,
    fontSize: 14.sp,
  );
  static TextStyle font12GreenBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.green,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  // Yellow
  static TextStyle font12YellowBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.yellow,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16YellowBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.yellow,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  // Blue
  static TextStyle font18BlueBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.darkBlue,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  // Pink
  static TextStyle font18PinkBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.pink,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  // Butbel
  static TextStyle font12BurbelBold = TextStyle(
    fontFamily: 'Almarai',
    color: ColorsManager.burbel,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
}
