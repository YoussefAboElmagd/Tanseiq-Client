import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class AnalysisByStatus extends StatelessWidget {
  const AnalysisByStatus({super.key, required this.cubit});
  final ComplainsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30.h,
                getTitlesWidget:
                    (value, meta) => Text(
                      cubit.complainStatus[value.toInt()].status,
                      style: TextStyles.font10BlackBold,
                    ),
              ),
            ),
          ),
          barGroups:
              cubit.complainStatus
                  .map(
                    (item) => BarChartGroupData(
                      barsSpace: 3,
                      x: cubit.complainStatus.indexOf(item),
                      barRods:
                          item.problemStatus
                              .map(
                                (e) => BarChartRodData(
                                  toY: e.totalCount.toDouble(),
                                  color: StatusColor[e.status]!,
                                  // colorsAnalysis[item.problemStatus.indexOf(
                                  //   e,
                                  // )],
                                  width: 10.w,
                                  borderRadius: BorderRadius.zero,
                                ),
                              )
                              .toList(),
                    ),
                  )
                  .toList(),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => ColorsManager.soft2Grey,
            ),
          ),
        ),
      ),
    );
  }
}
