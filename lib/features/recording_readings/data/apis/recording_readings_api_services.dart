import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_all_generators_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_developer_company_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_map_points.dart';

part 'recording_readings_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RecordingReadingsApiServices {
  factory RecordingReadingsApiServices(Dio dio, {String baseUrl}) =
      _RecordingReadingsApiServices;

  @GET(ApiConstants.getDropDownZoneFilter)
  Future<List<GetZoneResponse>> getDropDownZoneFilter();

  @GET(ApiConstants.getDropDownDeveloper)
  Future<List<GetDeveloperCompanyResponse>> getDropDownDeveloper();

  @GET(ApiConstants.getFilterCompany)
  Future<List<GetDropDownFilterResponse>> getDropDownFilter();

  @GET(ApiConstants.getSerialsGenerators)
  Future<List<GetGeneratorsSerialsResponse>> getGeneratorsSerials();

  @POST(ApiConstants.getMapPoints)
  Future<List<GetMapPoints>> getMapPoints(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.getReadings)
  Future<GetAllGeneratorsResponse> getReadings(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.getReadingsView)
  Future<List<GetGeneratorsReadingByTime>> getReadingsView(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.saveReading)
  Future saveReading(@Body() FormData formData);
}
