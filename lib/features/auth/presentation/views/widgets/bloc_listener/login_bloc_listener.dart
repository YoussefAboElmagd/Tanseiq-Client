import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: false, child: circular),
          );
        }
        if (state is LoginSuccess) {
          context.popAlert();
          context.pushNamed(
            Routes.otp,
            arguments: {
              'isFromLogin': true,
              'isFromRecover': false,
              'email': (state).data.returnedValue.toString(),
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: state.data.message!,
              color: ColorsManager.green,
            ),
          );
        }
        if (state is LoginError) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.error));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
