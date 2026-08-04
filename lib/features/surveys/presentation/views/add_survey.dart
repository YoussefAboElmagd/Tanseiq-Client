import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/survey_bloc_listener.dart';

class AddSurvey extends StatelessWidget {
  const AddSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      builder: (context, state) {
        var cubit = SurveyCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const ArrowBack(),
            title: Text(
              'إضافة استبيان جديد',
              style: TextStyles.font18BlackBold,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسم الاستبيان', style: TextStyles.font16Grey),
                    5.height,
                    CustomFormField(
                      controller: cubit.nameController,
                      hint: 'استبيان 1',
                      isHint: true,
                      validator: Constant.normalValidator(context: context),
                    ),
                    20.height,
                    Text('وصف الاستبيان', style: TextStyles.font16Grey),
                    5.height,
                    CustomFormField(
                      controller: cubit.descriptionController,
                      hint: 'وصف الاستبيان',
                      isHint: true,
                      validator: (value) {},
                    ),
                    20.height,
                    Text('تاريخ البدء', style: TextStyles.font16Grey),
                    5.height,
                    SelectDate(
                      onChanged: (DateTime? date) {
                        cubit.startDate = date.toString().split(' ')[0];
                      },
                    ),
                    20.height,
                    Text('تاريخ الانتهاء', style: TextStyles.font16Grey),
                    5.height,
                    SelectDate(
                      onChanged: (DateTime? date) {
                        cubit.endDate = date.toString().split(' ')[0];
                      },
                    ),
                    20.height,
                    Text('الحد الاقصي للاجابات', style: TextStyles.font16Grey),
                    5.height,
                    CustomFormField(
                      controller: cubit.maxEntriesController,
                      hint: '00',
                      keyboardType: TextInputType.number,
                      isHint: true,
                      validator: (value) {},
                    ),
                    5.height,
                    TextButton(
                      onPressed: () {
                        cubit.clear();
                      },
                      child: Text(
                        'مسح النصوص',
                        style: TextStyles.font14RedBold,
                      ),
                    ),
                    20.height,
                    CustomButton(
                      title: 'حفظ',
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.emitCreateSurvey(context: context);
                        }
                      },
                    ),
                    const SurveyBlocListener(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
