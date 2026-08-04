import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_field.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_post_request.dart';
import 'package:tanseiq/features/surveys/data/models/get_all_surveys_response.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';

part 'survey_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SurveyApiServices {
  factory SurveyApiServices(Dio dio, {String baseUrl}) = _SurveyApiServices;

  @POST(ApiConstants.surveys)
  Future createSurvey(@Body() AddSurveyPostRequest body);

  @POST('${ApiConstants.surveysFields}/{id}')
  Future createFieldSurvey(
    @Path('id') String id,
    @Body() AddSurveyFieldsPostRequest body,
  );

  @GET(ApiConstants.surveys)
  Future<List<GetAllSurveysResponse>> getAllSurvey();

  @GET('${ApiConstants.surveys}/{id}')
  Future<GetSurveyByIdResponse> getSurveyById(@Path('id') String id);
}
