import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/auth_component.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/login_attributes.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/bloc_listener/login_bloc_listener.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: AuthComponent(
            height: 550.h,
            title: 'تسجيل الدخول',
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Text(
                    'ادخل الايميل وكلمة المرور المؤقتة التي تم ارسالها لك في الدعوة',
                    style: TextStyles.font14MainColorBold,
                    textAlign: TextAlign.center,
                  ),
                  40.height,
                  LoginAttributes(cubit: cubit),
                  const LoginBlocListener(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
