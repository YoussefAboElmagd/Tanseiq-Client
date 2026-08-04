// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.hint,
    this.inputTextStyle,
    this.hintStyle,
    this.isObsecured,
    this.suffixIcon,
    this.fillColor,
    this.controller,
    this.enabled,
    this.prefixIcon,
    this.maxLines,
    required this.validator,
    this.borderColor,
    this.keyboardType,
    this.maxLength,
    this.isHint,
    this.contentHorPadding,
    this.contentVerPadding,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 1000),
    this.onFieldSubmitted,
    this.textInputAction,
  });
  final String hint;
  final bool? isHint;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final bool? isObsecured;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String?) validator;
  final double? contentHorPadding;
  final double? contentVerPadding;
  final Function(String)? onChanged;
  final Duration debounceDuration;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (widget.onChanged == null) return;

    // Cancel the previous timer if it's active
    _debounceTimer?.cancel();

    // Start a new timer
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged!(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      canRequestFocus: true,
      onChanged: _onChanged,
      inputFormatters: [
        // Corrected Unicode range syntax:
        FilteringTextInputFormatter.deny(
          RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true),
        ),
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      autofillHints: const [
        AutofillHints.name,
        AutofillHints.username,
        AutofillHints.email,
        AutofillHints.password,
        AutofillHints.newPassword,
        AutofillHints.oneTimeCode,
        AutofillHints.telephoneNumber,
        AutofillHints.postalAddress,
        AutofillHints.addressCityAndState,
        AutofillHints.addressState,
        AutofillHints.countryName,
        AutofillHints.addressCity,
      ],
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      maxLines: widget.maxLines ?? 1,
      enabled: widget.enabled ?? true,
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.contentHorPadding ?? 10.w,
          vertical: widget.contentVerPadding ?? 13.h,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.mainColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.grey.withOpacity(0.5),
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? ColorsManager.mainColor,
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
        label: widget.isHint != null ? null : Text(widget.hint),
        labelStyle: widget.hintStyle ?? TextStyles.font16Grey,
        hintText: widget.isHint != null ? widget.hint : null,
        hintStyle: widget.hintStyle ?? TextStyles.font16Grey,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: widget.fillColor ?? ColorsManager.white,
      ),
      cursorColor: ColorsManager.mainColor,
      obscureText: widget.isObsecured ?? false,
      style: widget.inputTextStyle ?? TextStyles.font16SoftBlackBold,
      validator: (value) {
        return widget.validator(value);
      },
    );
  }
}
