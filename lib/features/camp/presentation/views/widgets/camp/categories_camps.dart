import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';

class CategoriesCamps extends StatelessWidget {
  const CategoriesCamps({
    super.key,
    required this.titles,
    required this.statistics,
  });

  final List<String> titles;
  final GetHomeStatisticsResponse statistics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 4.h,
        ),
        itemBuilder:
            (context, index) => Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: const [
                  BoxShadow(
                    color: ColorsManager.softGrey,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 10.w,
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
                      width: 22.w,
                      height: 22.h,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          performanceindicatorsTitles[index],
                          style: TextStyles.font14SoftBlackBold,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                        10.height,
                        Text(
                          index == 0
                              ? statistics.camps.toString()
                              : index == 1
                              ? statistics.inProcessCamps.toString()
                              : index == 2
                              ? statistics.completedCamps.toString()
                              : statistics.delayedCamps.toString(),
                          style: styles[index],
                        ),
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
