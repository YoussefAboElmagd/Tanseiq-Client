import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/top_login_text.dart';

class AuthComponent extends StatelessWidget {
  const AuthComponent({
    super.key,
    required this.child,
    required this.title,
    this.height,
  });
  final Widget child;
  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        decoration: loginDecorationContainerFields,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
          height: height ?? 520.h,
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorsManager.mainColor, width: 1.w),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.softGrey,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopLoginText(title: title),
                20.height,
                Image.asset(
                  Assets.assetsImagesLogo,
                  width: double.infinity,
                  height: 100.h,
                  scale: 0.8,
                ),
                20.height,
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
