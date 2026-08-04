import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';

class AddFieldBlocListener extends StatelessWidget {
  const AddFieldBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyCubit, SurveyState>(
      listener: (context, state) {
        if (state is SurveyLoading) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(
              context: context,
              builder: (context) => PopScope(canPop: false, child: circular),
            );
          });
        }
        if (state is SurveySuccess) {
          context.popAlert();
          context
              .read<UiCubit>()
              .navigatorKeys[context.read<UiCubit>().currentIndex]
              .currentState!
              .popUntil((route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم انشاء حقل في الاستبيان بنجاح',
              color: Colors.green,
            ),
          );
        }
        if (state is SurveyError) {
          state.isBack ? context.popAlert() : null;
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(message: state.error, color: ColorsManager.red),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
