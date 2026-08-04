import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/auth/data/apis/auth_api_services.dart';
import 'package:tanseiq/features/auth/data/models/create_new_password_request_body.dart';
import 'package:tanseiq/features/auth/data/models/login_reponse_body.dart';
import 'package:tanseiq/features/auth/data/models/login_request_body.dart';

class AuthRepo {
  final AuthApiService authApiService;

  AuthRepo(this.authApiService);

  Future<ApiResult<LoginReponseBody>> login({
    required LoginRequestBody body,
  }) async {
    try {
      final response = await authApiService.login(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future sendOtp({required String email}) async {
    try {
      final response = await authApiService.resendOtp(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginReponseBody>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await authApiService.verifyOtp(email, code);

      return ApiResult.success(response);
    } catch (error) {
      print(error);
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginReponseBody>> resendOtp({required String email}) async {
    try {
      final response = await authApiService.resendOtp(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future resetPassword({required CreateNewPasswordRequestBody body}) async {
    try {
      final response = await authApiService.resetPassword(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future logout() async {
    try {
      final response = await authApiService.logout();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
