import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class AnswersDetails extends StatelessWidget {
  const AnswersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text('اليوم', style: TextStyles.font14MainColorBold),
        ),
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorsManager.soft3Grey,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Assets.assetsImagesProfile,
                width: 25.w,
                height: 25.h,
                color: ColorsManager.grey,
              ),
            ),
            10.width,
            Text('محمد احمد', style: TextStyles.font16SoftBlack),
            const Spacer(),
            Text('- قبل دقيقتين', style: TextStyles.font14SoftGrey3),
          ],
        ),
        5.height,
        Text('تغيرت المرحلة', style: TextStyles.font18MainColorBold),
        5.height,
        Row(
          spacing: 10.w,
          children: [
            Text('معلق', style: TextStyles.font16Grey),
            Image.asset(Assets.assetsImagesArrow1, width: 15.w, height: 15.h),
            Text('تم الاجابة ', style: TextStyles.font14GreenBold),
          ],
        ),
      ],
    );
  }
}
