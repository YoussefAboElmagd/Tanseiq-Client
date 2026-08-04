import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';
import 'package:tanseiq/features/home/data/models/main_report.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio, {String baseUrl}) = _HomeApiServices;

  @GET(ApiConstants.homeStatistics)
  Future<GetHomeStatisticsResponse> getHomeStatistics(
    @Query('RentalCompanyId') int companyId,
    @Query('ZoneId') int zoneId,
  );
  @POST(ApiConstants.getProblemStatusGraph)
  Future<List<MainReport>> getStatusProblem(@Body() Map<String, dynamic> body);
}
