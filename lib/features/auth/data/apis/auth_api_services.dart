import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/auth/data/models/create_new_password_request_body.dart';
import 'package:tanseiq/features/auth/data/models/login_reponse_body.dart';
import 'package:tanseiq/features/auth/data/models/login_request_body.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.userLogin)
  Future<LoginReponseBody> login(@Body() LoginRequestBody body);

  @POST(ApiConstants.userVerifyOtp)
  Future<LoginReponseBody> verifyOtp(
    @Query('identifier') String email,
    @Query('otpCode') String code,
  );
  @POST(ApiConstants.userResendOtp)
  Future<LoginReponseBody> resendOtp(@Query('identifier') String email);

  @POST(ApiConstants.userResetPassword)
  Future resetPassword(@Body() CreateNewPasswordRequestBody body);

  @POST(ApiConstants.userLogout)
  Future logout();
}
