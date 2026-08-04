import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/tint_analysis.dart';

class TintStatus extends StatelessWidget {
  const TintStatus({
    super.key,
    required this.compelete,
    required this.delay,
    required this.inProgress,
    required this.total,
  });
  final int compelete;
  final int delay;
  final int inProgress;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('حالة المخيمات', style: TextStyles.font18BlackBold),
        10.height,
        Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.softGrey,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
              BoxShadow(
                color: ColorsManager.softGrey,
                blurRadius: 5,
                offset: Offset(5, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اجمالي', style: TextStyles.font18GreenBold),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder:
                            (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 7.r,
                                  backgroundColor: tintStatusColor[index],
                                ),
                                10.width,
                                Text(
                                  tintStatusTitles[index],
                                  style: TextStyles.font14DarkGrey,
                                ),
                              ],
                            ),
                        itemCount: 3,
                        itemExtent: 30.h,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$total خيمة', style: TextStyles.font18GreenBold),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder:
                            (context, index) => Text(
                              textAlign: TextAlign.center,
                              index == 0
                                  ? compelete.toString()
                                  : index == 1
                                  ? inProgress.toString()
                                  : delay.toString(),
                              style: TextStyles.font14DarkGrey,
                            ),
                        itemCount: 3,
                        itemExtent: 34.h,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TintAnalysis(
                  total: total,
                  inProgress: inProgress,
                  delay: delay,
                  compelete: compelete,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
