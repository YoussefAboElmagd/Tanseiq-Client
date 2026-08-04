import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/surveys/data/apis/survey_api_services.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_field.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_post_request.dart';
import 'package:tanseiq/features/surveys/data/models/get_all_surveys_response.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';

class SurveyRepo {
  final SurveyApiServices surveyApiServices;

  SurveyRepo(this.surveyApiServices);

  Future createSurvey({required AddSurveyPostRequest body}) async {
    try {
      final response = await surveyApiServices.createSurvey(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future createFieldSurvey({
    required AddSurveyFieldsPostRequest body,
    required String id,
  }) async {
    try {
      final response = await surveyApiServices.createFieldSurvey(id, body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GetAllSurveysResponse>>> getAllSurvey() async {
    try {
      final response = await surveyApiServices.getAllSurvey();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetSurveyByIdResponse>> getSurveyById({
    required String id,
  }) async {
    try {
      final response = await surveyApiServices.getSurveyById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
