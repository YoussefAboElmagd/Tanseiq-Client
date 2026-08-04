import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_dimension_response.dart';
import 'package:tanseiq/features/map/data/apis/map_api_services.dart';

class MapRepo {
  final MapApiServices mapApiServices;
  MapRepo(this.mapApiServices);

  Future<ApiResult<List<GetAllCampsDimensionResponse>>>
  getAllCampsDimension() async {
    try {
      final response = await mapApiServices.getAllCampsDimension();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
