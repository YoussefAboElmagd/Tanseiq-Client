import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/networking/dio_factory.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/features/auth/data/models/create_new_password_request_body.dart';
import 'package:tanseiq/features/auth/data/models/login_request_body.dart';
import 'package:tanseiq/features/auth/data/repos/auth_repo.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  static AuthCubit get(context) => BlocProvider.of(context);

  bool sucured = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Timer? timer;
  int remainingSeconds = 30;
  bool canResend = true;

  Future startCountdown() async {
    remainingSeconds = 30;
    canResend = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) return;
      emit(StartCountDownState());
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        canResend = true;
        timer.cancel();
      }
    });
  }

  void isSecured() {
    sucured = !sucured;
    emit(ChangePasswordSecurityState());
  }

  void emitLogin() async {
    emit(LoginLoading());
    final response = await authRepo.login(
      body: LoginRequestBody(
        userName: emailController.text,
        password: passwordController.text,
      ),
    );
    await response.when(
      success: (data) async {
        if (data.isError) {
          // await DioFactory.setTokenAfterLogin(data.token);
          // await CachHelper.saveData(key: 'uid', value: data.token);
          emit(LoginError(data.message!));
        } else {
          emit(LoginSuccess(data));
        }
      },
      failure: (error) {},
    );
  }

  void emitSentOtp({required String email}) async {
    await startCountdown();
    emit(SendOtpLoading());
    final response = await authRepo.sendOtp(email: email);
    await response.when(
      success: (data) {
        emit(SendOtpSuccess('تم ارسال الرمز بنجاح'));
      },
      failure: (error) {
        emit(SendOtpError(error.failure.message ?? ''));
      },
    );
  }

  void emitVerifyOtp({required String email, required String otp}) async {
    emit(VerifyOtpLoading());
    final response = await authRepo.verifyOtp(
      email: email,
      code: otp,
    );
    print('response $response');
    await response.when(
      success: (data) async {
        print(data);
        if (!data.isError) {
          DioFactory.setTokenAfterLogin(data.token);
          await CachHelper.saveData(value: data.token, key: 'token');
          await CachHelper.saveData(value: data.userId, key: 'uid');

          await CachHelper.saveData(value: data.userType, key: 'userType');

          await CachHelper.saveData(
            value: data.returnedValue ?? email,
            key: 'email',
          );
          emit(VerifyOtpSuccess(data));
        } else {
          emit(VerifyOtpError(data.message!));
        }
      },
      failure: (error) {
        print('error: ${error.failure.message}');

        emit(VerifyOtpError('ايرور غير معروف برجاء المحاولة مره اخري'));
      },
    );
  }

  void emitResetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    final response = await authRepo.resetPassword(
      body: CreateNewPasswordRequestBody(
        email: email,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
    response.when(
      success: (data) {
        emit(ResetPasswordSuccess());
      },
      failure: (error) {
        emit(ResetPasswordError(error.failure.message ?? ''));
      },
    );
  }

  void emitLogout({required BuildContext context}) async {
    emit(LogoutLoading());
    final response = await authRepo.logout();
    await response.when(
      success: (data) async {
        await DioFactory.setTokenAfterLogin(null);
        await CachHelper.removeData(key: 'token');
        await CachHelper.removeData(key: 'isLogged');
        await CachHelper.removeData(key: 'uid');
        await Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
        emit(LogoutSuccess());
      },
      failure: (error) {
        context.popAlert();
        emit(LogoutError(error.failure.message ?? ''));
      },
    );
  }
}
