import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';

class RybReadingCard extends StatelessWidget {
  const RybReadingCard({super.key, required this.cubit});
  final ArafatElectricityCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.w,
        children: [
          DropDownListById(
            text: 'اختر رقم المحول ...',
            list: cubit.generatorsList,
            selectedValue:
                cubit.selectedGeneratorId.isEmpty
                    ? null
                    : cubit.selectedGeneratorId,
            onChanged: (id, _) {
              cubit.selectedGeneratorId = id ?? '';
            },
            validator: (v) => v == null || v.isEmpty ? 'مطلوب' : null,
            hintTextStyle: TextStyles.font12NormalGrey,
            iconHeight: 10.h,
            iconWidth: 10.w,
          ),
          _RybSection(cubit: cubit),
        ],
      ),
    );
  }
}

class _RybSection extends StatelessWidget {
  const _RybSection({required this.cubit});
  final ArafatElectricityCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.h,
      children: [
        Row(
          spacing: 4.w,
          children: const [
            _RybHeader(
              label: 'R',
              bgColor: ColorsManager.softRed,
              textColor: ColorsManager.red,
            ),
            _RybHeader(
              label: 'Y',
              bgColor: ColorsManager.softYellow,
              textColor: ColorsManager.yellow,
            ),
            _RybHeader(
              label: 'B',
              bgColor: ColorsManager.softBlue,
              textColor: ColorsManager.darkBlue,
            ),
          ],
        ),
        Row(
          spacing: 4.w,
          children: [
            _RybInput(
              controller: cubit.rController,
              borderColor: ColorsManager.red,
              textColor: ColorsManager.red,
              bgColor: ColorsManager.softRed,
            ),
            _RybInput(
              controller: cubit.yController,
              borderColor: ColorsManager.yellow,
              textColor: ColorsManager.yellow,
              bgColor: ColorsManager.softYellow,
            ),
            _RybInput(
              controller: cubit.bController,
              borderColor: ColorsManager.darkBlue,
              textColor: ColorsManager.darkBlue,
              bgColor: ColorsManager.softBlue,
            ),
          ],
        ),
      ],
    );
  }
}

class _RybHeader extends StatelessWidget {
  const _RybHeader({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });
  final String label;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 32.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Almarai',
          ),
        ),
      ),
    );
  }
}

class _RybInput extends StatelessWidget {
  const _RybInput({
    required this.controller,
    required this.borderColor,
    required this.textColor,
    required this.bgColor,
  });
  final TextEditingController controller;
  final Color borderColor;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Almarai',
        ),
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: TextStyle(
            color: textColor.withValues(alpha: 0.5),
            fontSize: 14.sp,
            fontFamily: 'Almarai',
          ),
          filled: true,
          fillColor: bgColor,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
        ),
        validator: (v) => v == null || v.isEmpty ? '' : null,
      ),
    );
  }
}
