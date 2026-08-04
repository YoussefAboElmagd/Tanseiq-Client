import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/add_new_survey_fields_button_design.dart';

class AddNewSurveyFieldsRow extends StatelessWidget {
  const AddNewSurveyFieldsRow({
    super.key,
    required this.addNewField,
    required this.id,
  });
  final Function()? addNewField;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        GestureDetector(
          onTap: () {},
          child: const AddNewSurveyFieldsButtonDesign(
            image: Assets.assetsImagesImport,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const AddNewSurveyFieldsButtonDesign(
            image: Assets.assetsImagesExport,
          ),
        ),
        GestureDetector(
          onTap: addNewField,
          child: const AddNewSurveyFieldsButtonDesign(
            image: Assets.assetsImagesAddNewField,
          ),
        ),
        Expanded(
          child: CustomButton(
            title: 'الاجابات',
            color: ColorsManager.green,
            onTap: () {
              context.pushNamed(Routes.answersSurvey, arguments: {'id': id});
            },
          ),
        ),
      ],
    );
  }
}
