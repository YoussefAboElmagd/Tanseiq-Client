import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';

class AttributesDropDownList extends StatelessWidget {
  const AttributesDropDownList({
    super.key,
    required this.list,
    required this.isRequired,
    this.hintTextStyle,
  });
  final List<FieldOption> list;
  final TextStyle? hintTextStyle;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return SurveyDropDownList(
      borderColor: ColorsManager.grey,
      textStyle: TextStyles.font16BlackBold,
      hintTextStyle: hintTextStyle ?? TextStyles.font16Grey,
      validator:
          isRequired ? Constant.dropDownListValidation(context: context) : null,
      text: 'اختر.....',
      list: list,
      selectedValue: '',
      onChanged: (String? value) {},
    );
  }
}
