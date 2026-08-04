import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_body_response.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_dimension_response.dart';
import 'package:tanseiq/features/camp/data/models/get_all_electrical_services.dart';
import 'package:tanseiq/features/camp/data/models/get_all_square_response.dart';
import 'package:tanseiq/features/camp/data/models/get_all_tent_request_body.dart';
import 'package:tanseiq/features/camp/data/models/get_all_tent_response_body.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_classifications_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_terms_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_building_preparing_works_request.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_building_works_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_details_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_preparing_works_response.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/camp/data/models/get_preparing_camp_service.dart';
import 'package:tanseiq/features/camp/data/models/post_request_camp.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';

part 'camp_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CampApiServices {
  factory CampApiServices(Dio dio, {String baseUrl}) = _CampApiServices;

  @GET(ApiConstants.camp)
  Future<List<GetAllCampsDimensionResponse>> getAllCampsDimension();

  @GET(ApiConstants.getAllCamp)
  Future<List<GetAllCampsBodyResponse>> getAllCamps();

  @GET(ApiConstants.getAllSquare)
  Future<List<GetAllSquareResponse>> getAllSquare();

  @POST(ApiConstants.camp)
  Future postRequestCamp(@Body() PostRequestCamp body);

  @POST(ApiConstants.allTents)
  Future<GetAllTentResponseBody> postRequestTent(
    @Body() GetAllTentRequestBody body,
  );
  @GET(ApiConstants.homeStatistics)
  Future<GetHomeStatisticsResponse> getStatistics(
    @Query('RentalCompanyId') int companyId,
    @Query('ZoneId') int zoneId,
  );

  @GET(ApiConstants.campDetails)
  Future<GetCampDetailsResponse> getCampDetails(@Query('Id') int id);

  @GET(ApiConstants.preparingCampServices)
  Future<GetPreparingCampService> getPreparingCampServices(@Query('id') int id);

  @POST(ApiConstants.campBuildingWorks)
  Future<GetCampBuildingWorksResponse> getCampBuildingWorks(
    @Body() GetCampBuildingPreparingWorksRequest body,
  );

  @GET(ApiConstants.getCampPreparingWorks)
  Future<List<GetCampPreparingWorksResponse>> getCampPreparingWorks(
    @Query('campId') int campId,
  );
  @POST(ApiConstants.electricalServices)
  Future<GetAllElectricalServices> getElectricalServices(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.updateElectScore)
  Future updateElectScore(@Query('id') int id);

  @GET(ApiConstants.getFilterCompany)
  Future<List<GetDropDownFilterResponse>> getDropDownFilter();

  @POST(ApiConstants.updateCampWork)
  Future updateCampWork(@Body() FormData formData);

  @POST(ApiConstants.updateItem)
  Future updateItem(@Body() FormData formData);

  @GET(ApiConstants.getCampPercentage)
  Future<List<GetCampAnalysisReponse>> getCampPercentage(
    @Query('RentalCompany') int company,
    @Query('ZoneId') int? zoneId,
    @Query('Status') int? status,
    @Query('ModifiedDate') DateTime? modifiedDate,
  );
  @GET(ApiConstants.getClassification)
  Future<List<GetCampAnalysisClassificationsResponse>> getClassification(
    @Query('RentalCompany') int company,
    @Query('ZoneId') int? zoneId,
    @Query('Status') int? status,
    @Query('ModifiedDate') DateTime? modifiedDate,
  );
  @GET(ApiConstants.getTerm)
  Future<List<GetCampAnalysisTermsResponse>> getTerms(
    @Query('RentalCompany') int company,
    @Query('ZoneId') int? zoneId,
    @Query('Status') int? status,
    @Query('ModifiedDate') DateTime? modifiedDate,
  );

  @GET(ApiConstants.getDropDownZoneFilter)
  Future<List<GetZoneResponse>> getDropDownZoneFilter();
}
