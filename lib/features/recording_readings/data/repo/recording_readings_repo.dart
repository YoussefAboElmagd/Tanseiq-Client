import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/recording_readings/data/apis/recording_readings_api_services.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_all_generators_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_developer_company_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_map_points.dart';

class RecordingReadingsRepo {
  final RecordingReadingsApiServices recordingReadingsApiServices;

  RecordingReadingsRepo(this.recordingReadingsApiServices);

  Future<ApiResult<List<GetZoneResponse>>> getDropDownZoneFilter() async {
    try {
      final response =
          await recordingReadingsApiServices.getDropDownZoneFilter();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetDropDownFilterResponse>>> getDropDownFilter() async {
    try {
      final response = await recordingReadingsApiServices.getDropDownFilter();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetDeveloperCompanyResponse>>>
  getDropDownDeveloper() async {
    try {
      final response =
          await recordingReadingsApiServices.getDropDownDeveloper();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetAllGeneratorsResponse>> getReadings({
    required int page,
    required int pageSize,
    required int serviceCompanyId,
    required int generatorId,
    required int zoneId,
    required int developerCompanyId,
  }) async {
    try {
      final response = await recordingReadingsApiServices.getReadings({
        'page': page,
        'pageSize': pageSize,
        'serviceCompanyId': serviceCompanyId,
        'generatorId': generatorId,
        'zoneId': zoneId,
        'developerCompanyId': developerCompanyId,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetMapPoints>>> getMapPoints({
    int serviceCompanyId = 0,
    int zoneId = 0,
    int generatorId = 0,
    int developerCompanyId = 0,
  }) async {
    try {
      final response = await recordingReadingsApiServices.getMapPoints({
        'serviceCompanyId': serviceCompanyId,
        'zoneId': zoneId,
        'generatorId': generatorId,
        'developerCompanyId': developerCompanyId,
      });
      List<GetMapPoints> points =
          response
              .where(
                (point) =>
                    point.latitude != null &&
                    point.longitude != null &&
                    point.id != null,
              )
              .toSet()
              .toList();
      return ApiResult.success(points);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetGeneratorsSerialsResponse>>>
  getGeneratorsSerials() async {
    try {
      final response =
          await recordingReadingsApiServices.getGeneratorsSerials();
      final List<GetGeneratorsSerialsResponse> generator =
          response
              .where((generator) => generator.name != null)
              .toSet()
              .toList();
      return ApiResult.success(generator);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetGeneratorsReadingByTime>>> getReadingsView({
    required int rentalCompanyId,
    required int developerCompanyId,
  }) async {
    try {
      final response = await recordingReadingsApiServices.getReadingsView({
        'date': DateTime.now().toIso8601String(),
        'rentalCompanyId': rentalCompanyId,
        'developerCompanyId': developerCompanyId,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future saveReading({
    required double r,
    required double y,
    required double b,
    required int generatorId,
    required File? image,
  }) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('GeneratorId', generatorId.toString()));
      formData.fields.add(MapEntry('CurrentR', r.toString()));
      formData.fields.add(MapEntry('CurrentY', y.toString()));
      formData.fields.add(MapEntry('CurrentB', b.toString()));
      if (image != null && await image.exists()) {
        final bytes = await image.readAsBytes();
        formData.files.add(MapEntry(
          'Image',
          MultipartFile.fromBytes(bytes, filename: image.path.split('/').last),
        ));
      }
      final response = await recordingReadingsApiServices.saveReading(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
