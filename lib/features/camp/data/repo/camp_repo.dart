import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/camp/data/apis/camp_api_services.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_body_response.dart';
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

class CampRepo {
  final CampApiServices campApiServices;
  CampRepo(this.campApiServices);

  Future<ApiResult<List<GetAllCampsBodyResponse>>> getAllCamps() async {
    try {
      final response = await campApiServices.getAllCamps();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetAllSquareResponse>>> getAllSquare() async {
    try {
      final response = await campApiServices.getAllSquare();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future postRequestCamp(PostRequestCamp body) async {
    try {
      final response = await campApiServices.postRequestCamp(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetAllTentResponseBody>> postRequestTent(
    GetAllTentRequestBody body,
  ) async {
    try {
      final response = await campApiServices.postRequestTent(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetHomeStatisticsResponse>> getStatistics() async {
    try {
      final response = await campApiServices.getStatistics(0, 0);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetPreparingCampService>> getPreparingCampServices(
    int id,
  ) async {
    try {
      final response = await campApiServices.getPreparingCampServices(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetCampDetailsResponse>> getCampDetails(int id) async {
    try {
      final response = await campApiServices.getCampDetails(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetCampBuildingWorksResponse>> getCampBuildingWorks(
    GetCampBuildingPreparingWorksRequest body,
  ) async {
    try {
      final response = await campApiServices.getCampBuildingWorks(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetCampPreparingWorksResponse>>> getCampPreparingWorks(
    int body,
  ) async {
    try {
      final response = await campApiServices.getCampPreparingWorks(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetCampPreparingWorksResponse>>> getElectricalServices(
    int campId,
    int page,
  ) async {
    try {
      final response = await campApiServices.getElectricalServices({
        'page': page,
        'pageSize': 10,
        'campId': campId,
      });
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetDropDownFilterResponse>>> getDropDownFilter() async {
    try {
      final response = await campApiServices.getDropDownFilter();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future updateCampWork(
    int id,
    String? notes,
    File? image,
    double? rate,
  ) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('Id', id.toString()));
      formData.fields.add(MapEntry('Notes', notes ?? ''));
      formData.fields.add(MapEntry('CompletionRate', (rate ?? 0).toString()));
      if (image != null && await image.exists()) {
        final bytes = await image.readAsBytes();
        formData.files.add(MapEntry(
          'CampWorkPhotoFile',
          MultipartFile.fromBytes(bytes, filename: image.path.split('/').last),
        ));
      }
      final response = await campApiServices.updateCampWork(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future updateItem(int id, String? notes, File? image, double? rate) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('Id', id.toString()));
      formData.fields.add(MapEntry('Description', notes ?? ''));
      formData.fields.add(MapEntry('CompelationRate', (rate ?? 0).toString()));
      if (image != null && await image.exists()) {
        final bytes = await image.readAsBytes();
        formData.files.add(MapEntry(
          'Photo',
          MultipartFile.fromBytes(bytes, filename: image.path.split('/').last),
        ));
      }
      final response = await campApiServices.updateItem(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetCampAnalysisReponse>>> getCampPercentage(
    int company,
    int? zoneId,
    int? status,
    DateTime? modifiedDate,
  ) async {
    try {
      final response = await campApiServices.getCampPercentage(
        company,
        zoneId,
        status,
        modifiedDate,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetCampAnalysisClassificationsResponse>>>
  getClassification(
    int company,
    int? zoneId,
    int? status,
    DateTime? modifiedDate,
  ) async {
    try {
      final response = await campApiServices.getClassification(
        company,
        zoneId,
        status,
        modifiedDate,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetCampAnalysisTermsResponse>>> getTerms(
    int company,
    int? zoneId,
    int? status,
    DateTime? modifiedDate,
  ) async {
    try {
      final response = await campApiServices.getTerms(
        company,
        zoneId,
        status,
        modifiedDate,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetZoneResponse>>> getDropDownZoneFilter() async {
    try {
      final response = await campApiServices.getDropDownZoneFilter();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future updateElectScore({required int id}) async {
    try {
      final response = await campApiServices.updateElectScore(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
