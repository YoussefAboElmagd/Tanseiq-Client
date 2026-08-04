import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/air_conditioners_photos.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/electric_form.dart';

class WaterKettlesDetails extends StatelessWidget {
  const WaterKettlesDetails({
    super.key,
    required this.selectedValue,
    this.runningController,
    this.totalController,
    this.detailsController,
    this.kadanaController,
    this.onTap,
    this.deviceType,
  });

  final String? selectedValue;
  final TextEditingController? runningController;
  final TextEditingController? totalController;
  final TextEditingController? detailsController;
  final TextEditingController? kadanaController;
  final void Function()? onTap;
  final String? deviceType;

  bool get _showDetails =>
      selectedValue != null && selectedValue != 'notApplicable';

  @override
  Widget build(BuildContext context) {
    if (!_showDetails) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
      ),
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ElectricForm(
                  title: 'من أصل عدد',
                  formHint: '23',
                  controller: totalController,
                  keyboardType: TextInputType.number,
                  validator: Constant.normalValidator(context: context),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElectricForm(
                  title: 'تم تشغيل عدد',
                  formHint: '20',
                  controller: runningController,
                  keyboardType: TextInputType.number,
                  validator: Constant.normalValidator(context: context),
                ),
              ),
            ],
          ),
          ElectricForm(
            title: 'تفاصيل',
            formHint: 'ادخل تفاصيل',
            keyboardType: TextInputType.text,
            controller: detailsController,
          ),
          ElectricForm(
            title: 'رقم بلاغ كدانة',
            formHint: '1234',
            controller: kadanaController,
            keyboardType: TextInputType.number,
          ),
          AirConditionersStatusPhotos(
            onTap: onTap,
            deviceType: deviceType ?? '',
          ),
        ],
      ),
    );
  }
}
