// Changelog:
// 2026-03-27 - Youssef Helmy
// - Changed getAllCampsByCompanyId from @GET with @Query params to @POST with @Body (JSON Map)
// - Changed getElectricCampsByCompanyId from @GET with @Query params to @POST with @Body (JSON Map)
// - Fixed 415 Unsupported Media Type by switching from FormData to Map<String, dynamic>

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_electric_hypothesis_response.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_water_hypothesis_response.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/electric_zone_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_camp_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_sub_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_square_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_zone_model.dart';

part 'electricity_hypotheses_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ElectricityHypothesesApiServices {
  factory ElectricityHypothesesApiServices(Dio dio, {String baseUrl}) =
      _ElectricityHypothesesApiServices;

  @GET(ApiConstants.getAllZonesWaterHypotheses)
  Future<List<WaterZoneModel>> getAllZones();

  @GET(ApiConstants.getAllSquaresWaterHypotheses)
  Future<List<WaterSquareModel>> getAllSquares();

  @POST(ApiConstants.getAllCampsByCompanyId)
  Future<List<WaterCampModel>> getAllCampsByCompanyId(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.getAllWaterCamps)
  Future<List<WaterCampModel>> getAllCamps();

  @GET(ApiConstants.getAllNoteTypesWaterHypotheses)
  Future<List<WaterNoteTypeModel>> getAllNoteTypes();

  @GET('${ApiConstants.getAllNoteTypesWaterHypotheses}/{noteTypeId}/sub-types')
  Future<List<WaterNoteSubTypeModel>> getNoteSubTypesByNoteTypeId(
    @Path('noteTypeId') int noteTypeId,
  );

  @POST(ApiConstants.addWaterHypothesis)
  Future<AddWaterHypothesisResponse> addWaterHypothesis(
    @Body() FormData formData,
  );

  @GET(ApiConstants.getElectricZones)
  Future<List<ElectricZoneModel>> getElectricZones();

  @GET(ApiConstants.getElectricSquare)
  Future<List<WaterSquareModel>> getElectricSquares();

  @POST(ApiConstants.getAllCampsByCompanyId)
  Future<List<WaterCampModel>> getElectricCampsByCompanyId(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.saveElectricHypothesis)
  Future<AddElectricHypothesisResponse> addElectricHypothesis(
    @Body() FormData formData,
  );
}
