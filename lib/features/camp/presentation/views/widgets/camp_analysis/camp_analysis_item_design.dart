import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/camp_analysis_pie_char.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/camp_data_analysis.dart';

class CampAnalysisItemDesign extends StatelessWidget {
  const CampAnalysisItemDesign({
    super.key,
    required this.campAnalysis,
    required this.onRefresh,
    required this.zoneId,
  });
  final int zoneId;
  final List<GetCampAnalysisReponse> campAnalysis;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: ColorsManager.mainColor,
      color: ColorsManager.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: campAnalysis.length,
        itemBuilder:
            (context, index) => Container(
              height: 190.h,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: const [
                  BoxShadow(
                    color: ColorsManager.softGrey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CampDataAnalysis(
                            zoneId: zoneId,
                            campAnalysis: campAnalysis[index],
                          ),
                        ),
                        Expanded(
                          child: CampAnalysisPieChart(
                            percentage:
                                zoneId == 0
                                    ? campAnalysis[index]
                                        .totalCompletionPercentage
                                        .toString()
                                    : zoneId == 1
                                    ? campAnalysis[index]
                                        .totalCompletionPercentageBasedOnMina
                                        .toString()
                                    : campAnalysis[index]
                                        .totalCompletionPercentageBasedOnArafat
                                        .toString(),
                          ),
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
