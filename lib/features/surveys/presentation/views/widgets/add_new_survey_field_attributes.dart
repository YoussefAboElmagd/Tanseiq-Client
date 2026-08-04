import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/phone_form_field.dart';
import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/close_dialog_row.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/upload_file_button_design.dart';

class AddNewSurveyFieldAttributes extends StatelessWidget {
  const AddNewSurveyFieldAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CloseDialogRow(),
          const Divider(),
          10.height,
          Text('نص', style: TextStyles.font16DarkGrey),
          5.height,
          CustomFormField(
            borderColor: ColorsManager.grey,
            hint: 'محتوى',
            keyboardType: TextInputType.text,
            isHint: true,
            validator: Constant.normalValidator(context: context),
          ),
          10.height,
          Text('تاريخ', style: TextStyles.font16DarkGrey),
          5.height,
          SelectDate(
            borderColor: ColorsManager.grey,
            iconColor: ColorsManager.grey,
            validator: Constant.startDateValidation(context: context),
          ),
          10.height,
          // AttributesDropDownList(
          //   hintTextStyle: TextStyles.font16DarkGrey,
          //   list: const ['الفئة2', 'الفئة1'],
          // ),
          10.height,
          const PhoneFormField(),
          10.height,
          CustomFormField(
            maxLines: 5,
            borderColor: ColorsManager.grey,
            hint: 'محتوي نصي',
            hintStyle: TextStyles.font16DarkGrey,
            keyboardType: TextInputType.text,
            isHint: true,
            validator: Constant.normalValidator(context: context),
          ),
          10.height,
          Row(
            children: [
              Radio(value: false, groupValue: true, onChanged: (_) {}),
              Text('اختيار', style: TextStyles.font16BlackBold),
            ],
          ),
          10.height,
          GestureDetector(onTap: () {}, child: const UploadFileButtonDesign()),
          10.height,
          const Divider(),
          20.height,
          CustomButton(
            title: 'اختيار',
            textStyle: TextStyles.font14WhiteBold,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
