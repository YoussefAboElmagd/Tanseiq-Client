import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_serials_response_pagination.dart';

part 'hypothesis_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HypothesisApiServices {
  factory HypothesisApiServices(Dio dio, {String baseUrl}) =
      _HypothesisApiServices;

  @POST(ApiConstants.getSerialsGeneratorsPagination)
  Future<GetGeneratorsSerialsResponsePagination> getGeneratorsSerials(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.saveReading)
  Future saveReading(@Body() FormData formData);

  @POST(ApiConstants.getReadingsView)
  Future<List<GetGeneratorsReadingByTime>> getReadingsView(@Body() String date);
}
