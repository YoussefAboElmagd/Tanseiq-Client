import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(Assets.assetsImagesArrowBackAR, width: 15.w),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
