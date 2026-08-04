import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/survey_item.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/surveys_app_bar.dart';

class AddAndDisplaySurveys extends StatefulWidget {
  const AddAndDisplaySurveys({super.key});

  @override
  State<AddAndDisplaySurveys> createState() => _AddAndDisplaySurveysState();
}

class _AddAndDisplaySurveysState extends State<AddAndDisplaySurveys> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SurveyCubit>(context).emitGetAllSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      builder: (context, state) {
        var cubit = SurveyCubit.get(context);
        if (state is GetAllSurveysLoading) {
          return const LoadingWidget();
        }
        return Scaffold(
          body: RefreshIndicator(
            backgroundColor: ColorsManager.white,
            color: ColorsManager.mainColor,
            onRefresh: () async => cubit.emitGetAllSurveys(),
            child:
                state is GetAllSurveysError
                    ? EmptyList(text: state.error)
                    : CustomScrollView(
                      slivers: [
                        SurveysAppBar(
                          onTap: () {
                            context.pushNamed(Routes.addSurvey);
                          },
                        ),
                        SliverList.builder(
                          itemCount:
                              cubit.allSurveys.isEmpty
                                  ? 1
                                  : cubit.allSurveys.length,
                          itemBuilder:
                              (context, index) =>
                                  cubit.allSurveys.isEmpty
                                      ? const EmptyList(
                                        imageColor: ColorsManager.mainColor,
                                      )
                                      : GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                            Routes.surveyDetails,
                                            arguments: {
                                              'id':
                                                  cubit.allSurveys[index].id
                                                      .toString(),
                                            },
                                          );
                                        },
                                        child: SurveyItem(
                                          status:
                                              cubit.allSurveys[index].status,
                                          title: cubit.allSurveys[index].name,
                                        ),
                                      ),
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
