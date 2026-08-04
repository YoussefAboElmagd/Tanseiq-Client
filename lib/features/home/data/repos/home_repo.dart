import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/home/data/apis/home_api_services.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';
import 'package:tanseiq/features/home/data/models/main_report.dart';

class HomeRepo {
  final HomeApiServices homeApiServices;

  HomeRepo(this.homeApiServices);

  Future<ApiResult<GetHomeStatisticsResponse>> getHomeStatistics() async {
    try {
      final response = await homeApiServices.getHomeStatistics(0, 0);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<MainReport>>> getStatusProblem() async {
    try {
      final response = await homeApiServices.getStatusProblem({});
      print(response);
      return ApiResult.success(response);
    } catch (error) {
      print(error);
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
