import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampAnalysisPieChart extends StatelessWidget {
  const CampAnalysisPieChart({super.key, required this.percentage});
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              centerSpaceRadius: 30.r,
              sectionsSpace: 0,
              startDegreeOffset: 90,
              borderData: FlBorderData(show: true),
              sections: [
                PieChartSectionData(
                  showTitle: false,
                  color: ColorsManager.green2,
                  value: double.parse(percentage),
                  radius: 12.r,
                ),
                PieChartSectionData(
                  showTitle: false,
                  color: ColorsManager.soft3Grey,
                  value: 100 - double.parse(percentage),
                  radius: 12.r,
                ),
              ],
            ),
          ),
          Text('$percentage %', style: TextStyles.font16BlackBold),
        ],
      ),
    );
  }
}
