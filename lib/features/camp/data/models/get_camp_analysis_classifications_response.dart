import 'package:json_annotation/json_annotation.dart';

part 'get_camp_analysis_classifications_response.g.dart';

@JsonSerializable()
class GetCampAnalysisClassificationsResponse {
  final String classification;
  final double averageCampWorkScore;

  GetCampAnalysisClassificationsResponse({
    required this.classification,
    required this.averageCampWorkScore,
  });

  factory GetCampAnalysisClassificationsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCampAnalysisClassificationsResponseFromJson(json);
}
