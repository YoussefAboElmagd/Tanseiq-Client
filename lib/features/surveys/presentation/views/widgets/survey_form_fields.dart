import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/attributres_drop_down_list.dart';

class SurveyFormFields extends StatelessWidget {
  const SurveyFormFields({
    super.key,
    required this.isRequired,
    required this.enable,
    required this.title,
    required this.type,
    required this.list,
    required this.onTap,
  });
  final bool isRequired;
  final bool enable;
  final String title;
  final int type;
  final List<FieldOption> list;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    if (type == 1 || type == 2 || type == 4) {
      return CustomFormField(
        enabled: enable,
        borderColor: ColorsManager.grey,
        hint: title,
        keyboardType: type == 4 ? TextInputType.text : TextInputType.number,
        validator:
            isRequired ? Constant.normalValidator(context: context) : (val) {},
      );
    }
    if (type == 5) {
      return enable
          ? AttributesDropDownList(isRequired: isRequired, list: list)
          : Container(
            height: 45.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              border: Border.all(color: ColorsManager.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text('اختر', style: TextStyles.font16Grey),
                const Spacer(),
                Image.asset(
                  Assets.assetsImagesDownArrow,
                  width: 15.w,
                  color: ColorsManager.grey,
                ),
              ],
            ),
          );
    }
    if (type == 6) {
      return enable
          ? SelectDate(
            borderColor: ColorsManager.grey,
            iconColor: ColorsManager.grey,
            validator:
                isRequired
                    ? Constant.startDateValidation(context: context)
                    : null,
          )
          : Container(
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
          );
    }
    if (type == 7) {
      return enable
          ? GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsManager.green,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text('رفع ملف', style: TextStyles.font16WhiteBold),
            ),
          )
          : Container(
            width: double.infinity,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              border: Border.all(color: ColorsManager.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('رفع ملف', style: TextStyles.font16BlackBold),
          );
    }
    if (type == 3) {
      return enable
          ? DropDownList(
            borderColor: ColorsManager.grey,
            textStyle: TextStyles.font16BlackBold,
            hintTextStyle: TextStyles.font16Grey,
            validator:
                isRequired
                    ? Constant.dropDownListValidation(context: context)
                    : null,
            text: 'اختر.....',
            list: const ['نعم', 'لا'],
            selectedValue: '',
            onChanged: (String? value) {},
          )
          : Container(
            height: 45.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              border: Border.all(color: ColorsManager.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text('اختر', style: TextStyles.font16Grey),
                const Spacer(),
                Image.asset(
                  Assets.assetsImagesDownArrow,
                  width: 15.w,
                  color: ColorsManager.grey,
                ),
              ],
            ),
          );
    }
    return const SizedBox.shrink();
  }
}
