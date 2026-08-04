import 'package:json_annotation/json_annotation.dart';

part 'get_complain_status_analysis_response.g.dart';

@JsonSerializable()
class GetComplainStatusAnalysisResponse {
  final String status;
  final int totalCount;
  @JsonKey(name: 'problemTypes')
  final List<ProblemStatus> problemStatus;

  GetComplainStatusAnalysisResponse({
    required this.status,
    required this.totalCount,
    required this.problemStatus,
  });

  factory GetComplainStatusAnalysisResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetComplainStatusAnalysisResponseFromJson(json);
}

@JsonSerializable()
class ProblemStatus {
  @JsonKey(name: 'type')
  final String status;
  final int totalCount;
  ProblemStatus({required this.status, required this.totalCount});

  factory ProblemStatus.fromJson(Map<String, dynamic> json) =>
      _$ProblemStatusFromJson(json);
}
