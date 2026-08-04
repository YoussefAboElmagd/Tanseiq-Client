import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';

class PrepareAnalysisItem extends StatelessWidget {
  const PrepareAnalysisItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      height: 130.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.w,
        children: [
          Expanded(
            child: StatusDropDownListById(
              text: 'جاري العمل',
              list: statusDropdown,
              selectedValue: '',
              textStyle: TextStyles.font14BlackBold,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    centerSpaceRadius: 40.r,
                    sectionsSpace: 0,
                    startDegreeOffset: 20,
                    borderData: FlBorderData(show: true),
                    sections: [
                      PieChartSectionData(
                        showTitle: false,
                        color: ColorsManager.mainColor,
                        value: 70,
                        radius: 15.r,
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        color: ColorsManager.soft3Grey,
                        value: 30,
                        radius: 15.r,
                      ),
                    ],
                  ),
                ),
                Text('70%', style: TextStyles.font18DarkGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
