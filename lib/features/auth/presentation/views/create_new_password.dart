import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/auth_component.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/bloc_listener/create_new_password_bloc_listener.dart';

class CreateNewPassowrd extends StatelessWidget {
  const CreateNewPassowrd({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: AuthComponent(
            height: 460.h,
            title: 'إنشاء كلمة مرور',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: cubit.passwordController,
                      isObsecured: true,
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: ColorsManager.darkGrey,
                        size: 25.r,
                      ),
                      hint: 'كلمة السر',
                      validator: Constant.passwrodValidator(context: context),
                    ),
                    25.height,
                    CustomFormField(
                      controller: cubit.confirmPasswordController,
                      isObsecured: true,
                      hintStyle: TextStyles.font16Grey,
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: ColorsManager.darkGrey,
                        size: 25.r,
                      ),
                      hint: 'تأكيد كلمة السر',
                      validator: Constant.confrimPasswordValidation(
                        context: context,
                        password: cubit.passwordController.text,
                      ),
                    ),
                    25.height,
                    CustomButton(
                      title: 'تأكيد',
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.emitResetPassword(email: email);
                        }
                      },
                    ),
                    const CreateNewPasswordBlocListener(),
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
