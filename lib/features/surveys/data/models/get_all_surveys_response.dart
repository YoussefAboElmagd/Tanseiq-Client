import 'package:json_annotation/json_annotation.dart';

part 'get_all_surveys_response.g.dart';

@JsonSerializable()
class GetAllSurveysResponse {
  final dynamic id;
  final String name;
  final String status;

  GetAllSurveysResponse({
    required this.id,
    required this.name,
    required this.status,
  });

  factory GetAllSurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllSurveysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSurveysResponseToJson(this);
}
