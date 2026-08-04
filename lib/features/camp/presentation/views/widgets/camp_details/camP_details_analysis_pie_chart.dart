import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampDetailsAnalysisPieChart extends StatelessWidget {
  const CampDetailsAnalysisPieChart({super.key, required this.compelted});
  final double compelted;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            centerSpaceRadius: 70.r,
            sectionsSpace: 0,
            startDegreeOffset: 90,
            borderData: FlBorderData(show: true),
            sections: [
              PieChartSectionData(
                showTitle: false,
                color: ColorsManager.green,
                value: 30,
                radius: 25.r,
              ),
              PieChartSectionData(
                showTitle: false,
                color: ColorsManager.yellow,
                value: 35,
                radius: 25.r,
              ),
              PieChartSectionData(
                showTitle: false,
                color: ColorsManager.red,
                value: 35,
                radius: 25.r,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$compelted %', style: TextStyles.font16BlackBold),
            Text('جاهز', style: TextStyles.font16Grey),
          ],
        ),
      ],
    );
  }
}
