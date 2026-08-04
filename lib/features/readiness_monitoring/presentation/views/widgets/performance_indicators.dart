import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class Performanceindicators extends StatelessWidget {
  const Performanceindicators({
    super.key,
    required this.total,
    required this.compelete,
    required this.delay,
    required this.inProgress,
  });
  final int total;
  final int compelete;
  final int delay;
  final int inProgress;

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
                color: ColorsManager.softGrey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Assets.assetsImagesPerformence,
                width: 20.w,
                height: 20.h,
              ),
            ),
            10.width,
            Text('مؤشرات الأداء', style: TextStyles.font18BlackBold),
          ],
        ),
        SizedBox(
          height: 290.h,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.h,
            ),
            itemBuilder:
                (context, index) => Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorsManager.softGrey,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    spacing: 5.w,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[index],
                        ),
                        child: Image.asset(
                          images[index],
                          width: 25.w,
                          height: 25.h,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              performanceindicatorsTitles[index],
                              style: TextStyles.font14SoftBlackBold,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            10.height,
                            Text(
                              index == 0
                                  ? inProgress.toString()
                                  : index == 1
                                  ? total.toString()
                                  : index == 2
                                  ? compelete.toString()
                                  : delay.toString(),
                              style: styles[index],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
