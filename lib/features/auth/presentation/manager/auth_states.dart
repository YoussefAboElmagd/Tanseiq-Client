import 'package:tanseiq/features/auth/data/models/login_reponse_body.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class ChangePasswordSecurityState extends AuthStates {}

class StartCountDownState extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final LoginReponseBody data;

  LoginSuccess(this.data);
}

class LoginError extends AuthStates {
  final String error;

  LoginError(this.error);
}

class SendOtpLoading extends AuthStates {}

class SendOtpSuccess extends AuthStates {
  final String message;

  SendOtpSuccess(this.message);
}

class SendOtpError extends AuthStates {
  final String error;

  SendOtpError(this.error);
}

class VerifyOtpLoading extends AuthStates {}

class VerifyOtpSuccess extends AuthStates {
  final LoginReponseBody body;

  VerifyOtpSuccess(this.body);
}

class VerifyOtpError extends AuthStates {
  final String error;

  VerifyOtpError(this.error);
}

class ResetPasswordLoading extends AuthStates {}

class ResetPasswordSuccess extends AuthStates {}

class ResetPasswordError extends AuthStates {
  final String error;

  ResetPasswordError(this.error);
}

class LogoutLoading extends AuthStates {}

class LogoutSuccess extends AuthStates {}

class LogoutError extends AuthStates {
  final String error;

  LogoutError(this.error);
}
