import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/arafat_electricity_reading/data/apis/arafat_electricity_api_services.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';

class ArafatElectricityRepo {
  final ArafatElectricityApiServices _apiServices;

  ArafatElectricityRepo(this._apiServices);

  Future<ApiResult<List<GetGeneratorsSerialsResponse>>>
  getGeneratorsSerials() async {
    try {
      final response = await _apiServices.getGeneratorsSerials();
      return ApiResult.success(
        response.where((g) => g.name != null).toList(),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> saveReading({
    required int generatorId,
    required double r,
    required double y,
    required double b,
    required String serviceCompanyId,
    required File? image,
  }) async {
    try {
      final formData = FormData();
      formData.fields
        ..add(MapEntry('GeneratorId', generatorId.toString()))
        ..add(MapEntry('CurrentR', r.toString()))
        ..add(MapEntry('CurrentY', y.toString()))
        ..add(MapEntry('CurrentB', b.toString()))
        ..add(MapEntry('ServiceCompany', serviceCompanyId))
        ..add(MapEntry('Time', DateTime.now().toIso8601String()));
      if (image != null && await image.exists()) {
        final bytes = await image.readAsBytes();
        formData.files.add(MapEntry(
          'Image',
          MultipartFile.fromBytes(bytes, filename: image.path.split('/').last),
        ));
      }
      final response = await _apiServices.saveReading(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
