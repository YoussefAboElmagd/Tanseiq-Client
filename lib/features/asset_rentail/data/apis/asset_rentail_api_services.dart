import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/asset_rentail/data/models/get_all_assets_response.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';

part 'asset_rentail_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AssetRentailApiServices {
  factory AssetRentailApiServices(Dio dio, {String baseUrl}) =
      _AssetRentailApiServices;

  @GET(ApiConstants.getAllCampNumber)
  Future<List<GetAllCamps>> getAllCampNumber();

  @GET(ApiConstants.getFilterCompany)
  Future<List<GetDropDownFilterResponse>> getRentailCompany();

  @GET(ApiConstants.getDropDownDeveloper)
  Future<List<GetDropDownFilterResponse>> getDropDownDeveloper();

  @POST(ApiConstants.getRejectedAssets)
  Future<GetAllAssetsResponse> getRejectedAssets(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.getAllAssets)
  Future<GetAllAssetsResponse> getAllAssets(@Body() Map<String, dynamic> body);
}
