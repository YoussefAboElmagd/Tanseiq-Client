import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';

const Map<String, String> kPeriodLabels = {
  'period-1': 'الفترة الأولى (٨ص – ١٢م)',
  'period-2': 'الفترة الثانية (١٢م – ٤م)',
  'period-3': 'الفترة الثالثة (٤م – ٨م)',
};

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({super.key, required this.cubit});
  final ArafatElectricityCubit cubit;

  @override
  Widget build(BuildContext context) {
    final label = kPeriodLabels[cubit.selectedPeriod] ?? '';
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorsManager.mainColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: [
            Container(
              width: 6.r,
              height: 6.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white,
              ),
            ),
            Text(label, style: TextStyles.font12WhiteBold),
          ],
        ),
      ),
    );
  }
}
