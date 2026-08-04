import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({super.key, this.borderColor, this.enabled});
  final Color? borderColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      enabled: enabled ?? true,
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.mainColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.grey.withOpacity(0.5),
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.grey,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorStyle: TextStyles.font12Red,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintStyle: TextStyles.font16Grey,
        filled: true,
        hintText: 'الجوال',
        hintTextDirection: TextDirection.rtl,
        fillColor: ColorsManager.white,
      ),
      languageCode: 'ar',
      cursorColor: ColorsManager.mainColor,
      flagsButtonMargin: EdgeInsets.only(right: 10.w),
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: ColorsManager.white,
        countryCodeStyle: TextStyles.font16BlackBold,
        countryNameStyle: TextStyles.font16BlackBold,
        searchFieldCursorColor: ColorsManager.mainColor,
        searchFieldInputDecoration: InputDecoration(
          hintStyle: TextStyles.font16Grey,
          filled: true,
          fillColor: ColorsManager.white,
          contentPadding: EdgeInsets.only(left: 10.w),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.mainColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsManager.grey, width: 2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: 'بحث',
        ),
      ),
      initialCountryCode: 'SA',
      validator: (value) {
        if (value!.number.isEmpty) {
          return 'يجب ملئ هذا الحقل';
        }
        return null;
      },
      onCountryChanged: (country) {
        // cubit.phoneCode = country.dialCode;
      },
    );
  }
}
