import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';

class ElectricForm extends StatelessWidget {
  final String? title;
  final String? formHint;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function(String?)? validator;
  const ElectricForm({
    super.key,
    this.title,
    this.formHint,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? 'تقديم فرضيه الكهرباء', style: TextStyles.font14Grey),
        10.height,
        CustomFormField(
          controller: controller,
          hint: formHint ?? '12-23',
          validator: validator ?? (val) {},
          borderColor: ColorsManager.soft3Grey,
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
