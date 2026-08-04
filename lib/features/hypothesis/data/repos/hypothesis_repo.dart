import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/hypothesis/data/apis/hypothesis_api_services.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_serials_response_pagination.dart';

class HypothesisRepo {
  final HypothesisApiServices hypothesisApiServices;

  HypothesisRepo(this.hypothesisApiServices);

  Future<ApiResult<GetGeneratorsSerialsResponsePagination>>
  getGeneratorsSerials(int page) async {
    try {
      final response = await hypothesisApiServices.getGeneratorsSerials({
        'page': page,
        'pageSize': 30,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetGeneratorsReadingByTime>>> getReadingsView() async {
    try {
      final response = await hypothesisApiServices.getReadingsView(
        DateTime.now().toString(),
      );
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
      final response = await hypothesisApiServices.saveReading(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
