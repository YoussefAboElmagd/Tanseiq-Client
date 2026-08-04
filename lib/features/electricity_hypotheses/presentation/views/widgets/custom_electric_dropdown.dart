import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';

class CustomElectriceDropDown extends StatelessWidget {
  final String? title;
  final String? formHint;
  final List? list;
  final Function(String?, dynamic)? onChanged;
  final String? selectedValue;

  const CustomElectriceDropDown({
    super.key,
    this.title,
    this.formHint,
    this.list,
    this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? 'تقديم فرضيه الكهرباء', style: TextStyles.font14Grey),
        10.height,
        DropDownListById(
          text: formHint ?? '',
          list: list ?? [],
          selectedValue: selectedValue,
          borderColor: ColorsManager.soft3Grey,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
