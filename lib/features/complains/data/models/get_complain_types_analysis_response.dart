import 'package:json_annotation/json_annotation.dart';

part 'get_complain_types_analysis_response.g.dart';

@JsonSerializable()
class GetComplainTypesAnalysisResponse {
  final String type;
  final int totalCount;
  @JsonKey(name: 'problemStatus')
  final List<ProblemTypes> problemTypes;

  GetComplainTypesAnalysisResponse({
    required this.type,
    required this.totalCount,
    required this.problemTypes,
  });

  factory GetComplainTypesAnalysisResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetComplainTypesAnalysisResponseFromJson(json);
}

@JsonSerializable()
class ProblemTypes {
  @JsonKey(name: 'status')
  final String type;
  final int totalCount;
  ProblemTypes({required this.type, required this.totalCount});

  factory ProblemTypes.fromJson(Map<String, dynamic> json) =>
      _$ProblemTypesFromJson(json);
}
