import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';

class LoginAttributes extends StatelessWidget {
  const LoginAttributes({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomFormField(
              controller: cubit.emailController,
              hint: 'الايميل',
              validator: Constant.normalValidator(context: context),
            ),
            25.height,
            CustomFormField(
              controller: cubit.passwordController,
              isObsecured: cubit.sucured,
              suffixIcon: IconButton(
                onPressed: cubit.isSecured,
                icon: Icon(
                  cubit.sucured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: ColorsManager.darkGrey,
                  size: 25.r,
                ),
              ),
              hint: 'كلمة السر',
              validator: Constant.passwrodValidator(context: context),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.pushNamed(Routes.recoverAccount);
                },
                child: Text(
                  'نسيت كلمة السر؟',
                  style: TextStyles.font12GreenUnderLine,
                ),
              ),
            ),
            CustomButton(
              title: 'تسجيل الدخول',
              onTap: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.emitLogin();
                }
              },
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
