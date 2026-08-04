import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';

part 'support_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SupportApiServices {
  factory SupportApiServices(Dio dio, {String baseUrl}) = _SupportApiServices;

  @POST(ApiConstants.usersSupport)
  Future addSupportMessage(@Body() FormData formData);
}
