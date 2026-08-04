import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/add_field_bloc_listener.dart';

class AddNewSurveyFieldScreen2 extends StatefulWidget {
  const AddNewSurveyFieldScreen2({
    super.key,
    required this.attributeName,
    required this.id,
  });
  final String attributeName;
  final String id;

  @override
  State<AddNewSurveyFieldScreen2> createState() =>
      _AddNewSurveyFieldScreen2State();
}

bool isRequired = false;
bool isUnique = false;

class _AddNewSurveyFieldScreen2State extends State<AddNewSurveyFieldScreen2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      builder: (context, state) {
        var cubit = SurveyCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const ArrowBack(),
            title: Text(
              'تعديل حقل جديد',
              style: TextStyles.font18MainColorBold,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      controller: cubit.nameController,
                      hint: 'عنوان',
                      isHint: true,
                      validator: Constant.normalValidator(context: context),
                    ),
                    10.height,
                    CustomFormField(
                      controller: cubit.descriptionController,
                      hint: 'نص مساعد',
                      isHint: true,
                      validator: (value) {},
                    ),
                    10.height,
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ColorsManager.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          value: isRequired,
                          onChanged: (value) {
                            setState(() {
                              isRequired = value!;
                            });
                          },
                        ),
                        Text('اجباري', style: TextStyles.font14BlackBold),
                      ],
                    ),
                    10.height,
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ColorsManager.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          value: isUnique,
                          onChanged: (value) {
                            setState(() {
                              isUnique = value!;
                            });
                          },
                        ),
                        Text('اجابة فريدة', style: TextStyles.font14BlackBold),
                      ],
                    ),
                    10.height,
                    const Divider(),
                    20.height,
                    CustomButton(
                      title: 'اضافة',
                      textStyle: TextStyles.font14WhiteBold,
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.emitCreateFieldSurvey(
                            id: widget.id,
                            isRequired: isRequired,
                            isUnique: isUnique,
                            context: context,
                            type: getType(attribute: widget.attributeName),
                          );
                        }
                      },
                    ),
                    const AddFieldBlocListener(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int getType({required String attribute}) {
    if (attribute == 'رقم الهاتف') {
      return 10;
    }
    if (attribute == 'محتوي نصي') {
      return 9;
    }
    if (attribute == 'نص') {
      return 4;
    }
    if (attribute == 'تاريخ') {
      return 6;
    }
    if (attribute == 'رفع الملف') {
      return 7;
    }
    return -1;
  }
}
