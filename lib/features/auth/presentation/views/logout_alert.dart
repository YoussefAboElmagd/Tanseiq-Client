import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/di/dependency_injection.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/networking/dio_factory.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/alert_design.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getit()),
      child: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          // var cubit = AuthCubit.get(context);
          if (state is LogoutLoading) {
            return circular;
          }
          return AlertDesign(
            title: Text(
              'هل تريد تسجيل الخروج؟',
              textAlign: TextAlign.center,
              style: TextStyles.font16BlackBold,
            ),
            content: SizedBox(
              height: 140.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '- سوف تحتاج إلى تسجيل الدخول مرة أخرى',
                    style: TextStyles.font16DarkGrey,
                  ),
                  Text(
                    '- اعداداتك سيتم حفظها',
                    style: TextStyles.font16DarkGrey,
                  ),
                  Text(
                    '- سوف يتم الاحتفاظ بالبيانات الخاصة بك',
                    style: TextStyles.font16DarkGrey,
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        // cubit.emitLogout(context: context);
                        await DioFactory.setTokenAfterLogin(null);
                        await CachHelper.removeData(key: 'token');
                        await CachHelper.removeData(key: 'isLogged');
                        await CachHelper.removeData(key: 'uid');
                        await Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.login,
                          (route) => false,
                        );
                      },
                      title: 'تسجيل الخروج',
                      textStyle: TextStyles.font14WhiteBold,
                      color: ColorsManager.darkRed,
                    ),
                  ),
                  10.width,
                  CustomButton(
                    width: 70.w,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: 'إلغاء',
                    textStyle: TextStyles.font14WhiteBold,
                    color: ColorsManager.mainColor,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
