import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/complains/data/models/check_package_response.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_option_types_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_status_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_types_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complains_types.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';

part 'complains_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ComplainsApiServices {
  factory ComplainsApiServices(Dio dio, {String baseUrl}) =
      _ComplainsApiServices;

  @GET(ApiConstants.getAllCampNumber)
  Future<List<GetAllCamps>> getAllCampNumber(@Query('zoneId') int zoneId);

  @GET(ApiConstants.getAllWaterCamps)
  Future<List<GetAllCamps>> getAllCamps();

  @POST(ApiConstants.checkPackage)
  Future<CheckPackageResponse> checkPackage(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.getProblemTypes)
  Future<List<GetComplainsTypes>> getComplainsTypes();

  @GET(ApiConstants.getDropDownZoneFilter)
  Future<List<GetZoneResponse>> getDropDownZoneFilter();

  @GET(ApiConstants.problemById)
  Future<ComplainsData> problemById(@Query('id') int id);

  @POST(ApiConstants.getAllProblems)
  Future<GetAllComplainsResponse> getAllProblems(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.saveProblem)
  Future addProblem({
    @Part(name: 'Address') required String title,
    @Part(name: 'Description') required String? description,
    @Part(name: 'ReporterName') required String reporterName,
    @Part(name: 'PhoneNumber') required String phone,
    @Part(name: 'Date') required String date,
    @Part(name: 'CampId') required int campId,
    @Part(name: 'Camp') required String camp,
    @Part(name: 'problemTypeCode') required int problemTypeCode,
    @Part(name: 'ProblemType') required String problemType,
    @Part(name: 'Location') required String? location,
    @Part(name: 'Files') required List<File>? images,
  });

  @GET(ApiConstants.getProblemCadanaTypes)
  Future<List<GetComplainsTypes>> getComplainsInCadanaTypes();

  @GET(ApiConstants.problemCadanaById)
  Future<ComplainsData> problemCadanaById(@Query('id') int id);

  @POST(ApiConstants.getAllProblemCadana)
  Future<GetAllComplainsResponse> getAllProblemCadana(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.saveProblemCadana)
  Future addProblemCadana({
    @Part(name: 'Address') required String title,
    @Part(name: 'Description') required String? description,
    @Part(name: 'ReporterName') required String reporterName,
    @Part(name: 'PhoneNumber') required String phone,
    @Part(name: 'Date') required String date,
    @Part(name: 'CampId') required int campId,
    @Part(name: 'Camp') required String camp,
    @Part(name: 'ZoneId') required int zoneId,
    @Part(name: 'Zone') required String zone,
    @Part(name: 'problemTypeCode') required int problemTypeCode,
    @Part(name: 'ProblemType') required String problemType,
    @Part(name: 'Location') required String? location,
    @Part(name: 'Files') required List<File>? images,
  });

  @GET(ApiConstants.getProblemSolvedCode)
  Future<String> getProblemSolvedCode(@Query('id') int id);

  @POST(ApiConstants.unSpecializedProblem)
  Future unSpecializedProblem(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.resolveProblem)
  Future resolveProblem(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.saveComment)
  Future saveComment({
    @Part(name: 'Content') required String content,
    @Part(name: 'ProblemId') required int id,
    @Part(name: 'Image') required File? image,
  });

  @GET(ApiConstants.getComplainsTypes)
  Future<List<GetComplainOptionTypesResponse>> getComplainOptionTypes();

  @GET(ApiConstants.getDropDownProblemStatus)
  Future<List<GetComplainOptionTypesResponse>> getProblemStatus();

  @POST(ApiConstants.getProblemStatusGraph)
  Future<List<GetComplainStatusAnalysisResponse>> getProblemStatusGraph(
    @Body() Map<String, dynamic> body,
  );
  @POST(ApiConstants.getProblemTypesGraph)
  Future<List<GetComplainTypesAnalysisResponse>> getProblemTypesGraph(
    @Body() Map<String, dynamic> body,
  );
}
