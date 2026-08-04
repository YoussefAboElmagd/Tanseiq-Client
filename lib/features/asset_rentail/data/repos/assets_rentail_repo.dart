import 'package:flutter/material.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/asset_rentail/data/apis/asset_rentail_api_services.dart';
import 'package:tanseiq/features/asset_rentail/data/models/get_all_assets_response.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';

class AssetsRentailRepo {
  final AssetRentailApiServices assetRentailApiServices;

  AssetsRentailRepo(this.assetRentailApiServices);

  Future<ApiResult<List<GetAllCamps>>> getAllCampNumber() async {
    try {
      final response = await assetRentailApiServices.getAllCampNumber();
      debugPrint('Before filtering: ${response.length}');

      final List<GetAllCamps> camp =
          response.where((camp) => camp.name != null).toSet().toList();
      debugPrint('After filtering: ${camp.length}');
      return ApiResult.success(camp);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetDropDownFilterResponse>>> getRentailCompany() async {
    try {
      final response = await assetRentailApiServices.getRentailCompany();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetDropDownFilterResponse>>>
  getDropDownDeveloper() async {
    try {
      final response = await assetRentailApiServices.getDropDownDeveloper();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetAllAssetsResponse>> getRejectedAssets({
    required int page,
    required String companyId,
    required String developerId,
    required String campNumber,
  }) async {
    try {
      final response = await assetRentailApiServices.getRejectedAssets({
        'page': page,
        'pageSize': 20,
        'companyId': companyId.isEmpty ? 0 : int.parse(companyId),
        'developerId': developerId.isEmpty ? 0 : int.parse(developerId),
        'campNumber': campNumber.isEmpty ? null : campNumber,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }

  Future<ApiResult<GetAllAssetsResponse>> getAllAssets({
    required int page,
    required String companyId,
    required String developerId,
    required String campNumber,
  }) async {
    try {
      final response = await assetRentailApiServices.getAllAssets({
        'page': page,
        'pageSize': 20,
        'companyId': companyId.isEmpty ? 0 : int.parse(companyId),
        'developerId': developerId.isEmpty ? 0 : int.parse(developerId),
        'campNumber': campNumber.isEmpty ? null : campNumber,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }
}
