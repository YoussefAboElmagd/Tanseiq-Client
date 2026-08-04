import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/water_kettles_details.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/yes_no_question.dart';

class ElectricDeviceSection extends StatelessWidget {
  const ElectricDeviceSection({
    super.key,
    required this.label,
    required this.deviceKey,
    required this.status,
    required this.onChanged,
    required this.cubit,
  });

  final String label;
  final String deviceKey;
  final String? status;
  final ValueChanged<String?> onChanged;
  final ElectricityHypothesesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        YesNoQuestion(
          question: label,
          groupValue: status,
          onChanged: onChanged,
          thirdOptionValue: 'notApplicable',
          thirdOptionLabel: 'لاينطبق',
        ),
        WaterKettlesDetails(
          selectedValue: status,
          runningController: cubit.runningCtrl[deviceKey],
          totalController: cubit.totalCtrl[deviceKey],
          detailsController: cubit.detailsCtrl[deviceKey],
          kadanaController: cubit.kadanaCtrl[deviceKey],
          deviceType: deviceKey,
          onTap: () => cubit.emitPickElectricImage(
            context: context,
            deviceType: deviceKey,
          ),
        ),
      ],
    );
  }
}
