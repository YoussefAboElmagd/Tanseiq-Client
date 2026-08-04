import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/complains/data/apis/complains_api_services.dart';
import 'package:tanseiq/features/complains/data/models/check_package_response.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_option_types_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_status_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_types_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complains_types.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';

class ComplainsRepo {
  ComplainsApiServices complainsApiServices;

  ComplainsRepo(this.complainsApiServices);

  Future<ApiResult<List<GetAllCamps>>> getAllCampNumber({
    required int zoneId,
  }) async {
    try {
      final response = await complainsApiServices.getAllCampNumber(zoneId);
      debugPrint('Before filtering: ${response.length}');

      final List<GetAllCamps> camp =
          response.where((camp) => camp.name != null).toSet().toList();
      debugPrint('After filtering: ${camp.length}');
      return ApiResult.success(camp);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetAllCamps>>> getAllCamps() async {
    try {
      final response = await complainsApiServices.getAllCamps();
      debugPrint('Before filtering: ${response.length}');

      final List<GetAllCamps> camp =
          response
              .where((camp) => camp.name != null && camp.name != '')
              .toSet()
              .toList();
      debugPrint('After filtering: ${camp.length}');
      return ApiResult.success(camp);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetZoneResponse>>> getDropDownZoneFilter() async {
    try {
      final response = await complainsApiServices.getDropDownZoneFilter();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CheckPackageResponse>> checkPackage({
    required int campId,
    required int problemTypeCode,
  }) async {
    try {
      final response = await complainsApiServices.checkPackage({
        'campId': campId,
        'problemTypeCode': problemTypeCode,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetComplainsTypes>>> getComplainsTypes() async {
    try {
      final response = await complainsApiServices.getComplainsTypes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetAllComplainsResponse>> getAllProblems({
    required int page,
    required int pageSize,
    required int problemStatus,
    required int problemType,
  }) async {
    try {
      final response = await complainsApiServices.getAllProblems({
        'page': page,
        'pageSize': pageSize,
        'problemStatus': problemStatus,
        'problemType': problemType,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<ComplainsData>> problemById({required int id}) async {
    try {
      final response = await complainsApiServices.problemById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future addProblem({
    required String title,
    required String reporterName,
    required String phone,
    required String date,
    required int campId,
    required String camp,
    required int problemTypeCode,
    required String problemType,
    String? location,
    String? description,
    List<File>? images,
  }) async {
    try {
      final result = await complainsApiServices.addProblem(
        title: title,
        description: description,
        reporterName: reporterName,
        phone: phone,
        date: date,
        campId: campId,
        camp: camp,
        problemTypeCode: problemTypeCode,
        problemType: problemType,
        location: location,
        images: images,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e.toString()));
    }
  }

  Future<ApiResult<GetAllComplainsResponse>> getAllProblemCadana({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await complainsApiServices.getAllProblemCadana({
        'page': page,
        'pageSize': pageSize,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<ComplainsData>> problemCadanaById({required int id}) async {
    try {
      final response = await complainsApiServices.problemCadanaById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future addProblemCadana({
    required String title,
    required String reporterName,
    required String phone,
    required String date,
    required int campId,
    required String camp,
    required int zoneId,
    required String zone,
    required int problemTypeCode,
    required String problemType,
    String? location,
    String? description,
    List<File>? images,
  }) async {
    try {
      final result = await complainsApiServices.addProblemCadana(
        title: title,
        description: description,
        reporterName: reporterName,
        phone: phone,
        date: date,
        campId: campId,
        camp: camp,
        zoneId: zoneId,
        zone: zone,
        problemTypeCode: problemTypeCode,
        problemType: problemType,
        location: location,
        images: images,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e.toString()));
    }
  }

  Future<ApiResult<String>> getProblemSolvedCode({required int id}) async {
    try {
      final response = await complainsApiServices.getProblemSolvedCode(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future unSpecializedProblem({required int id, required String code}) async {
    try {
      final response = await complainsApiServices.unSpecializedProblem({
        'id': id,
        'code': code,
        'date': DateTime.now().toIso8601String(),
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future resolveProblem({required int id, required String code}) async {
    try {
      final response = await complainsApiServices.resolveProblem({
        'id': id,
        'code': code,
        'date': DateTime.now().toIso8601String(),
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future saveComment({
    required int id,
    required String content,
    required File? image,
  }) async {
    try {
      final response = await complainsApiServices.saveComment(
        id: id,
        content: content,
        image: image,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<List<GetComplainOptionTypesResponse>>>
  getComplainOptionTypes() async {
    try {
      final response = await complainsApiServices.getComplainOptionTypes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<List<GetComplainOptionTypesResponse>>>
  getProblemStatus() async {
    try {
      final response = await complainsApiServices.getProblemStatus();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<List<GetComplainTypesAnalysisResponse>>>
  getProblemTypesGraph() async {
    try {
      final response = await complainsApiServices.getProblemTypesGraph({});
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<List<GetComplainStatusAnalysisResponse>>>
  getProblemStatusGraph() async {
    try {
      final response = await complainsApiServices.getProblemStatusGraph({});
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }
}
