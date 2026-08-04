import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/core/widgets/phone_form_field.dart';
import 'package:tanseiq/core/widgets/select_date.dart';

class TeamUserAttributes extends StatelessWidget {
  const TeamUserAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الاسم', style: TextStyles.font14Grey),
        5.height,
        CustomFormField(
          hint: 'ادخل الاسم',
          validator: Constant.normalValidator(context: context),
        ),
        10.height,
        Text('رقم الهاتف', style: TextStyles.font14Grey),
        5.height,
        const PhoneFormField(),
        10.height,
        Text('الوظيفة', style: TextStyles.font14Grey),
        5.height,
        CustomFormField(
          hint: 'ادخل الوظيفة',
          validator: Constant.normalValidator(context: context),
        ),
        10.height,
        Text('الايميل', style: TextStyles.font14Grey),
        5.height,
        CustomFormField(
          hint: 'ادخل الايميل',
          validator: Constant.normalValidator(context: context),
        ),
        10.height,
        Text('تاريخ الميلاد', style: TextStyles.font14Grey),
        5.height,
        SelectDate(),
        10.height,
        Text('تاريخ الانضمام', style: TextStyles.font14Grey),
        5.height,
        SelectDate(),
        10.height,
        Text('صلاحية الوصول', style: TextStyles.font14Grey),
        5.height,
        DropDownList(
          hintTextStyle: TextStyles.font14Grey,
          iconColor: ColorsManager.mainColor,
          text: 'صلاحية الوصول',
          list: const ['admin', 'user'],
          selectedValue: '',
        ),
      ],
    );
  }
}
