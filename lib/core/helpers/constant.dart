import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/phone_form_field.dart';
import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/upload_file_button_design.dart';

abstract class Constant {
  static DateTime? startDate;
  static DateTime? endDate;
  static dynamic Function(String?) normalValidator({
    required BuildContext context,
    String? warning,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return warning ?? 'يجب ملئ هذا الحقل';
    }
  };
  static dynamic Function(String?) passwrodValidator({
    required BuildContext context,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return 'يجب ملئ هذا الحقل';
    }
    if (value.length < 8) {
      return 'يجب أن يكون كلمة المرور على الأقل 8 حروف';
    }
  };
  static dynamic Function(String?) confrimPasswordValidation({
    required BuildContext context,
    required String password,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return 'يجب ملئ هذا الحقل';
    }
    if (password != value) {
      return 'كلمة المرور غير متطابقة';
    }
  };
  static String? Function(DateTime?)? startDateValidation({
    required BuildContext context,
    String? warning,
  }) => (DateTime? value) {
    if (value == null) {
      return 'يجب ملئ هذا الحقل';
    }
    return null; // No error
  };

  static String? Function(DateTime?)? endDateValidation({
    required BuildContext context,
    required DateTime startDate,
    String? warning,
  }) => (DateTime? endDate) {
    if (endDate == null) {
      return 'يجب ملئ هذا الحقل';
    }
    if (endDate.isBefore(startDate)) {
      return 'تاريخ الانتهاء يجب أن يكون بعد تاريخ البداية';
    }

    return null; // No error
  };

  static String? Function(String?)? dropDownListValidation({
    required BuildContext context,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return 'يجب ملئ هذا الحقل';
    }
    return null; // No error
  };
  static Widget returnTrueWidget(
    String attributeName,
    bool enable,
    BuildContext context,
  ) {
    if (attributeName == 'نص') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('نص', style: TextStyles.font16DarkGrey),
          5.height,
          CustomFormField(
            enabled: enable,
            borderColor: ColorsManager.grey,
            hint: 'محتوى',
            keyboardType: TextInputType.text,
            isHint: true,
            validator: Constant.normalValidator(context: context),
          ),
        ],
      );
    }
    if (attributeName == 'تاريخ') {
      return enable
          ? SelectDate()
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تاريخ', style: TextStyles.font16DarkGrey),
              5.height,
              Container(
                height: 50.h,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorsManager.white,
                  border: Border.all(color: ColorsManager.grey),
                ),
                child: Row(
                  children: [
                    Image(
                      height: 20.h,
                      width: 20.w,
                      color: ColorsManager.grey,
                      image: const AssetImage(Assets.assetsImagesCalender),
                    ),
                    const Spacer(),
                    Text('DD/MM/YYYY', style: TextStyles.font16Grey),
                  ],
                ),
              ),
            ],
          );
    }
    if (attributeName == 'رقم الهاتف') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('رقم الهاتف', style: TextStyles.font16DarkGrey),
          5.height,
          PhoneFormField(enabled: enable),
        ],
      );
    }
    if (attributeName == 'محتوي نصي') {
      return CustomFormField(
        enabled: enable,
        maxLines: 5,
        borderColor: ColorsManager.grey,
        hint: 'محتوي نصي',
        hintStyle: TextStyles.font16DarkGrey,
        keyboardType: TextInputType.text,
        isHint: true,
        validator: Constant.normalValidator(context: context),
      );
    }
    if (attributeName == 'رفع ملف') {
      return const UploadFileButtonDesign();
    }
    return const SizedBox.shrink();
  }
}
