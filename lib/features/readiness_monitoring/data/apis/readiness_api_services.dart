import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';

part 'readiness_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ReadinessApiServices {
  factory ReadinessApiServices(Dio dio, {String baseUrl}) =
      _ReadinessApiServices;

  @GET(ApiConstants.getCampPercentage)
  Future<List<GetCampAnalysisReponse>> getCampPercentage(
    @Query('RentalCompany') int company,
    @Query('ZoneId') int? zoneId,
    @Query('Status') int? status,
    @Query('ModifiedDate') DateTime? modifiedDate,
  );
}
