import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_terms_response.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/terms_data_analysis.dart';

class TermsItemDesign extends StatelessWidget {
  const TermsItemDesign({
    super.key,
    required this.campAnalysis,
    required this.onRefresh,
  });
  final List<GetCampAnalysisTermsResponse> campAnalysis;
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
        // itemCount: 10,
        itemBuilder:
            (context, index) => Container(
              height: 100.h,
              alignment: Alignment.center,
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
              child: TermsDataAnalysis(campAnalysis: campAnalysis[index]),
            ),
      ),
    );
  }
}
