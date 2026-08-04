import 'package:json_annotation/json_annotation.dart';

part 'get_camp_analysis_terms_response.g.dart';

@JsonSerializable()
class GetCampAnalysisTermsResponse {
  final String? term;
  final double? averageCampWorkScore;

  GetCampAnalysisTermsResponse({
    required this.term,
    required this.averageCampWorkScore,
  });

  factory GetCampAnalysisTermsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCampAnalysisTermsResponseFromJson(json);
}
