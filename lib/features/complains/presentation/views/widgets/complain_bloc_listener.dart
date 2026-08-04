import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';

class ComplainBlocListener extends StatelessWidget {
  const ComplainBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplainsCubit, ComplainsStates>(
      listener: (context, state) {
        if (state is AddComplainLoadingState) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: false, child: circular),
          );
        }
        if (state is GetCheckLoadingState) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: false, child: circular),
          );
        }
        if (state is GetCheckSuccessState) {
          context.popAlert();
        }
        if (state is AddComplainSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم اضافة البلاغ بنجاح',
              color: ColorsManager.green,
            ),
          );
          context.pop();
        }
        if (state is GetCheckErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message:
                  'الباقة المؤجرة لهذا المخيم لا تشمل هذا النوع من البلاغات، لذا فإن مسؤولية الإصلاح تقع عليك.',
              color: ColorsManager.red,
            ),
          );
        }
        if (state is AddComplainErrorState) {
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
