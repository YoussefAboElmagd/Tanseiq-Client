import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_dimension_response.dart';

part 'map_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MapApiServices {
  factory MapApiServices(Dio dio, {String baseUrl}) = _MapApiServices;

  @GET(ApiConstants.camp)
  Future<List<GetAllCampsDimensionResponse>> getAllCampsDimension();
}
