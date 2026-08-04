import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/auth_component.dart';

class RecoverAccount extends StatelessWidget {
  const RecoverAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(leading: const ArrowBack()),
          body: AuthComponent(
            height: 400.h,
            title: 'استرداد الحساب',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: cubit.emailController,
                      hint: 'الايميل',
                      validator: Constant.normalValidator(context: context),
                    ),
                    25.height,
                    CustomButton(
                      title: 'ارسال OTP',
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          context.pushNamed(
                            Routes.otp,
                            arguments: {
                              'isFromLogin': false,
                              'isFromRecover': true,
                              'email': cubit.emailController.text,
                            },
                          );
                        }
                      },
                    ),
                    10.height,
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'استقبال OTP علي رقم الهاتف؟',
                        style: TextStyles.font12GreenUnderLine,
                      ),
                    ),
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
