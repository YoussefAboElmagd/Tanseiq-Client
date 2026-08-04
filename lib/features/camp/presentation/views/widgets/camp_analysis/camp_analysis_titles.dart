import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';

class CampAnalysisTitles extends StatelessWidget {
  const CampAnalysisTitles({
    super.key,
    required this.title,
    required this.cubit,
    required this.index,
  });
  final String title;
  final int index;
  final CampCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.emitSelectCampAnalysisScreen(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color:
              index == cubit.currentCampAnalysis
                  ? ColorsManager.green
                  : const Color.fromARGB(255, 244, 244, 244),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style:
              index == cubit.currentCampAnalysis
                  ? TextStyles.font14WhiteBold
                  : TextStyles.font14SoftBlack,
        ),
      ),
    );
  }
}
