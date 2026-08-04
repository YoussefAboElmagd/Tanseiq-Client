import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';

part 'base_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BaseApiServices {
  factory BaseApiServices(Dio dio, {String baseUrl}) = _BaseApiServices;

  @GET(ApiConstants.checkRoute)
  Future checkRoute(
    @Query('UserId') int userId,
    @Query('SubRoute') String route,
  );
}
