import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/support/presentation/manager/support_cubit.dart';
import 'package:tanseiq/features/support/presentation/manager/support_states.dart';

class SupportBlocListenrer extends StatelessWidget {
  const SupportBlocListenrer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportCubit, SupportStates>(
      listener: (context, state) {
        if (state is UploadLoadingSupportState) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: true, child: circular),
          );
        }
        if (state is UploadSuccessSupportState) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم رفع الشكوي للمسؤول',
              color: ColorsManager.green,
            ),
          );
        }
        if (state is UploadErrorSupportState) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: state.error ?? 'حدث خطأ اثناء رفع الشكوي للمسؤول',
              color: ColorsManager.red,
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
