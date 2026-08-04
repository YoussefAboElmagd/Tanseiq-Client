import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_details/camP_details_analysis_pie_chart.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_details/text_design_tint_analysis_camp_details.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';
// import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';

class CampDetailsAnalysisItem extends StatelessWidget {
  const CampDetailsAnalysisItem({super.key, required this.tentStatistic});
  final GetHomeStatisticsResponse tentStatistic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Expanded(child: CampDetailsAnalysisPieChart(compelted: 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextDesignTintAnalysisCampDetials(
                text1: tentStatistic.camps.toString(),
                text2: 'اجمالي المخيمات',
                textStyle1: TextStyles.font16BlackBold,
              ),
              TextDesignTintAnalysisCampDetials(
                text1: tentStatistic.completedCamps.toString(),
                text2: 'مخيمات منتهية',
                textStyle1: TextStyles.font16GreenBold,
              ),
              TextDesignTintAnalysisCampDetials(
                text1: tentStatistic.inProcessCamps.toString(),
                text2: 'مخيمات قيد التنفيذ',
                textStyle1: TextStyles.font16YellowBold,
              ),
              TextDesignTintAnalysisCampDetials(
                text1: tentStatistic.delayedCamps.toString(),
                text2: 'مخيمات متاخرة',
                textStyle1: TextStyles.font16RedBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
