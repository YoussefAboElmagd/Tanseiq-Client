import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';
import 'package:tanseiq/features/readiness_monitoring/data/apis/readiness_api_services.dart';

class ReadinessRepo {
  final ReadinessApiServices readinessApiServices;

  ReadinessRepo(this.readinessApiServices);

  Future<ApiResult<List<GetCampAnalysisReponse>>> getCampPercentage(
    int company,
    int? zoneId,
    int? status,
    DateTime? modifiedDate,
  ) async {
    try {
      final response = await readinessApiServices.getCampPercentage(
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
}
