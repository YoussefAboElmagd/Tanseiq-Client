import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ResponseAvgerage extends StatelessWidget {
  const ResponseAvgerage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      height: 360.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
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
        border: Border.all(color: ColorsManager.mainColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                  Assets.assetsImagesExportFile,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
              10.width,
              Text('معدل الاستجابة', style: TextStyles.font18BlackBold),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemExtent: 100.h,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  centerSpaceRadius: 25.r,
                                  sectionsSpace: 0,
                                  startDegreeOffset: 90,
                                  borderData: FlBorderData(show: true),
                                  sections: [
                                    PieChartSectionData(
                                      showTitle: false,
                                      color: responseAvgColor[index],
                                      value: double.parse(
                                        tintStatusPercentage[index].toString(),
                                      ),
                                      radius: 8.r,
                                    ),
                                    PieChartSectionData(
                                      showTitle: false,
                                      color: ColorsManager.soft3Grey,
                                      value:
                                          100 -
                                          double.parse(
                                            tintStatusPercentage[index]
                                                .toString(),
                                          ),
                                      radius: 8.r,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${tintStatusPercentage[index].toString()}%',
                                style: responseAvgStyle[index],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'استجابة خلال 24ساعة',
                            style: TextStyles.font18BlackBold,
                          ),
                        ),
                        Expanded(
                          child: Text('12', style: responseAvgStyle[index]),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
