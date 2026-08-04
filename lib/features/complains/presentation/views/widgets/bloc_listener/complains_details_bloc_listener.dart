import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';

class ComplainsDetailsBlocListener extends StatelessWidget {
  const ComplainsDetailsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplainsCubit, ComplainsStates>(
      listener: (context, state) {
        if (state is SaveCommentLoadingState ||
            state is UnSpecializedProblemLoadingState ||
            state is ProblemSolvedLoadingState) {
          context.popAlert();
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: false, child: circular),
          );
        }
        if (state is SaveCommentSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم تصعيد البلاغ بنجاح',
              color: ColorsManager.green,
            ),
          );
        }
        if (state is UnSpecializedProblemSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم التبليغ بعدم الاختصاص بنجاح',
              color: ColorsManager.green,
            ),
          );
        }
        if (state is ProblemSolvedSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم الاصلاح بنجاح',
              color: ColorsManager.green,
            ),
          );
        }
        if (state is SaveCommentErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.errorMessage));
        }
        if (state is ProblemSolvedErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.errorMessage));
        }
        if (state is UnSpecializedProblemErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.errorMessage));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
