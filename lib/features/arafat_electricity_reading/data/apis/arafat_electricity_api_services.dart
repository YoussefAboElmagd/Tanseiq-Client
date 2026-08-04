import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';

part 'arafat_electricity_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ArafatElectricityApiServices {
  factory ArafatElectricityApiServices(Dio dio, {String baseUrl}) =
      _ArafatElectricityApiServices;

  @GET(ApiConstants.getSerialsGenerators)
  Future<List<GetGeneratorsSerialsResponse>> getGeneratorsSerials();

  @POST(ApiConstants.saveReading)
  Future saveReading(@Body() FormData formData);
}
