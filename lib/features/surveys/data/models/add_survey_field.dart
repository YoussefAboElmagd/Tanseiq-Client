import 'package:json_annotation/json_annotation.dart';

part 'add_survey_field.g.dart';

@JsonSerializable()
class AddSurveyFieldsPostRequest {
  final List<AddSurveyField> fields;

  AddSurveyFieldsPostRequest({required this.fields});

  factory AddSurveyFieldsPostRequest.fromJson(Map<String, dynamic> json) =>
      _$AddSurveyFieldsPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddSurveyFieldsPostRequestToJson(this);
}

@JsonSerializable()
class AddSurveyField {
  final String name;
  final String? description;
  final String? placeholder;
  final int type;
  final bool? isRequired;
  final bool? isUnique;

  AddSurveyField({
    required this.name,
    this.description,
    this.placeholder,
    required this.type,
    required this.isRequired,
    required this.isUnique,
  });

  factory AddSurveyField.fromJson(Map<String, dynamic> json) =>
      _$AddSurveyFieldFromJson(json);

  Map<String, dynamic> toJson() => _$AddSurveyFieldToJson(this);
}
