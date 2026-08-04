import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_terms_response.dart';

class TermsDataAnalysis extends StatelessWidget {
  const TermsDataAnalysis({super.key, required this.campAnalysis});
  final GetCampAnalysisTermsResponse campAnalysis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Expanded(
          child: Text(
            campAnalysis.term ?? 'غير محدد',
            style: TextStyles.font14BlackBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 5.h,
            barRadius: Radius.circular(10.r),
            percent: campAnalysis.averageCampWorkScore! / 100,
            backgroundColor: ColorsManager.grey.withOpacity(0.7),
            progressColor: ColorsManager.green,
          ),
        ),
        Expanded(
          child: Text(
            '${campAnalysis.averageCampWorkScore}%',
            style: TextStyles.font14Black,
          ),
        ),
      ],
    );
  }
}
