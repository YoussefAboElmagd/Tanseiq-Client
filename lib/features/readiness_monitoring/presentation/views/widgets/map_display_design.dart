import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class MapDisplayDesign extends StatelessWidget {
  const MapDisplayDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsManager.soft3Grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Assets.assetsImagesCarbonMap,
                width: 25.w,
                height: 25.h,
              ),
            ),
            10.width,
            Text('خريطة المخيمات', style: TextStyles.font18BlackBold),
          ],
        ),
        10.height,
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.mapDisplayAllPoints);
          },
          child: Container(
            width: double.infinity,
            height: 300.h,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              image: const DecorationImage(
                image: AssetImage(Assets.assetsImagesMap),
              ),
              border: Border.all(color: ColorsManager.mainColor, width: 3.w),
              boxShadow: const [
                BoxShadow(
                  color: ColorsManager.soft3Grey,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: ColorsManager.soft3Grey,
                  blurRadius: 5,
                  offset: Offset(5, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
