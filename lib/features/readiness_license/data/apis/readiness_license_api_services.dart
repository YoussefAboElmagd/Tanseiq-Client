import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';

part 'readiness_license_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ReadinessLicenseApiServices {
  factory ReadinessLicenseApiServices(Dio dio, {String baseUrl}) =
      _ReadinessLicenseApiServices;
}
