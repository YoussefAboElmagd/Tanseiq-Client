import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/add_new_survey_fields_row.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/attributes_description_row.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/empty_survey.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/survey_form_fields.dart';

class SurveyDetails extends StatefulWidget {
  const SurveyDetails({super.key, required this.id});
  final String id;
  @override
  State<SurveyDetails> createState() => _SurveyDetailsState();
}

class _SurveyDetailsState extends State<SurveyDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SurveyCubit>(context).emitGetSurveyById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      builder: (context, state) {
        var cubit = SurveyCubit.get(context);
        if (state is GetSurveyByIdLoading) return const LoadingWidget();
        if (state is GetSurveyByIdError) {
          return Scaffold(
            appBar: AppBar(
              leading: const ArrowBack(),
              title: Text('استبيان', style: TextStyles.font18BlackBold),
            ),
            body: EmptyList(text: state.error),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: const ArrowBack(),
              title: Text(
                cubit.surveyData.name,
                style: TextStyles.font18BlackBold,
              ),
            ),
            body: RefreshIndicator(
              backgroundColor: ColorsManager.white,
              color: ColorsManager.mainColor,
              onRefresh: () async => cubit.emitGetSurveyById(id: widget.id),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          10.height,
                          AddNewSurveyFieldsRow(
                            id: widget.id,
                            addNewField: () {
                              context.pushNamed(
                                Routes.addNewSurveyFieldScreen1,
                                arguments: {'id': widget.id},
                              );
                            },
                          ),
                          10.height,
                          const Divider(color: ColorsManager.mainColor),
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemBuilder:
                        (context, index) =>
                            cubit.surveyData.fields.isEmpty
                                ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: const EmptySurvey(),
                                )
                                : Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  child: Column(
                                    children: [
                                      AttributesDescriptionRow(
                                        title:
                                            cubit.surveyData.fields[index].name,
                                      ),
                                      5.height,
                                      SurveyFormFields(
                                        enable: false,
                                        onTap: () {
                                          cubit.emitPickAttachment(
                                            context: context,
                                          );
                                        },
                                        isRequired:
                                            cubit
                                                .surveyData
                                                .fields[index]
                                                .isRequired,
                                        title:
                                            cubit.surveyData.fields[index].name,
                                        type:
                                            cubit.surveyData.fields[index].type,
                                        list:
                                            cubit
                                                .surveyData
                                                .fields[index]
                                                .fieldOptions,
                                      ),
                                    ],
                                  ),
                                ),
                    itemCount:
                        cubit.surveyData.fields.isEmpty
                            ? 1
                            : cubit.surveyData.fields.length,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
