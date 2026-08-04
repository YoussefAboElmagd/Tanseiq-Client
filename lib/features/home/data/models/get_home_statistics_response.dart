import 'package:json_annotation/json_annotation.dart';

part 'get_home_statistics_response.g.dart';

@JsonSerializable()
class GetHomeStatisticsResponse {
  final int camps;
  final int completedCamps;
  final int inProcessCamps;
  final int delayedCamps;
  final int pendingCamps;

  GetHomeStatisticsResponse({
    required this.camps,
    required this.completedCamps,
    required this.inProcessCamps,
    required this.delayedCamps,
    required this.pendingCamps,
  });

  factory GetHomeStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHomeStatisticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHomeStatisticsResponseToJson(this);
}
