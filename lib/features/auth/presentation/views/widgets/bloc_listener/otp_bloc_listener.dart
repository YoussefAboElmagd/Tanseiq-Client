import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';

class OtpBlocListener extends StatelessWidget {
  const OtpBlocListener({
    super.key,
    required this.isFromLogin,
    required this.isFromRecover,
    required this.email,
  });
  final bool isFromLogin;
  final bool isFromRecover;
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SendOtpLoading) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: false, child: circular),
          );
        }
        if (state is SendOtpSuccess) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم ارسال رمز التحقق بنجاح',
              color: ColorsManager.green,
            ),
          );
        }
        if (state is SendOtpError) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.error));
        }
        if (state is VerifyOtpLoading) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(
              context: context,
              builder: (context) => PopScope(canPop: false, child: circular),
            );
          });
        }
        if (state is VerifyOtpSuccess) {
          context.popAlert();
          CachHelper.saveData(value: state.body.userName, key: 'uname');
          CachHelper.saveData(value: state.body.companyId, key: 'companyId');
          CachHelper.saveData(value: state.body.userType, key: 'userType');
          CachHelper.saveData(
            value: CachHelper.getData(key: 'token') != null ? true : false,
            key: 'isLogged',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'رمز التحقق صحيح',
              color: ColorsManager.green,
            ),
          );
          if (isFromLogin) {
            context.pushNamedAndRemoveUntill(Routes.baseLayer);
          }
          if (isFromRecover) {
            context.pushNamedAndRemoveUntill(
              Routes.createNewPassowrd,
              arguments: {'email': email},
            );
          }
        }
        if (state is VerifyOtpError) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: 'رمز التحقق خاطئ'));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
