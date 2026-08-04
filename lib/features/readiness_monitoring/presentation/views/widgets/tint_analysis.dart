import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class TintAnalysis extends StatelessWidget {
  const TintAnalysis({
    super.key,
    required this.compelete,
    required this.delay,
    required this.inProgress,
    required this.total,
  });
  final int total;
  final int compelete;
  final int delay;
  final int inProgress;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 40.r,
        startDegreeOffset: 15,
        sections: [
          PieChartSectionData(
            titleStyle: TextStyles.font14WhiteBold,
            color: ColorsManager.darkRed,
            value: ((delay / total) * 100).floorToDouble(),
            radius: 25.r,
          ),
          PieChartSectionData(
            color: ColorsManager.orange,
            value: ((inProgress / total) * 100).floorToDouble(),
            titleStyle: TextStyles.font14WhiteBold,
            radius: 25.r,
          ),
          PieChartSectionData(
            color: ColorsManager.green,
            value: ((compelete / total) * 100).floorToDouble(),
            titleStyle: TextStyles.font14WhiteBold,
            radius: 25.r,
          ),
        ],
      ),
    );
  }
}
