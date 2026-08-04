import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/networking/dio_factory.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
    this.image,
    this.text,
    this.imageColor,
    this.textStyle,
    this.onRefresh,
  });
  final String? image;
  final String? text;
  final Color? imageColor;
  final TextStyle? textStyle;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: ColorsManager.white,
      color: ColorsManager.mainColor,
      onRefresh: onRefresh ?? () async {},
      child: Center(
        child: SizedBox(
          height: 300.h,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                // height: 189.h,
                width: 270.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      image ?? Assets.assetsImagesError,
                      height: 60.h,
                      width: 60.w,
                      color: imageColor ?? ColorsManager.darkRed,
                    ),
                    10.height,
                    Text(
                      textAlign: TextAlign.center,
                      text == null
                          ? 'لا يوجد بيانات'
                          : text! == 'unauthorizedError'
                          ? 'يرجى تسجيل الدخول مرة اخري'
                          : text!,
                      style: textStyle ?? TextStyles.font16DarkRedBold,
                    ),
                    10.height,
                    text != null && text! == 'unauthorizedError'
                        ? TextButton(
                          onPressed: () async {
                            await DioFactory.setTokenAfterLogin(null);
                            await CachHelper.removeData(key: 'token');
                            await CachHelper.removeData(key: 'isLogged');
                            await CachHelper.removeData(key: 'uid');
                            await context.pushReplacementNamed(Routes.login);
                          },
                          child: Text(
                            'تسجيل الدخول مرة اخري',
                            style: textStyle ?? TextStyles.font16GreenUnderLine,
                          ),
                        )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
