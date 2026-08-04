import 'package:json_annotation/json_annotation.dart';

part 'add_survey_post_request.g.dart';

@JsonSerializable()
class AddSurveyPostRequest {
  final String name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final int? maxEntries;

  AddSurveyPostRequest({
    required this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.maxEntries,
  });

  factory AddSurveyPostRequest.fromJson(Map<String, dynamic> json) =>
      _$AddSurveyPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddSurveyPostRequestToJson(this);
}
