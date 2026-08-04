import 'package:json_annotation/json_annotation.dart';

part 'get_survey_by_id_response.g.dart';

@JsonSerializable()
class GetSurveyByIdResponse {
  final String name;
  final String? description;
  final List<SurveyField> fields;

  GetSurveyByIdResponse({
    required this.name,
    this.description,
    required this.fields,
  });

  factory GetSurveyByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSurveyByIdResponseFromJson(json);
}

@JsonSerializable()
class SurveyField {
  final int id;
  final String name;
  final String? description;
  final String? placeholder;
  final int type;
  final bool isRequired;
  final bool isUnique;
  final List<FieldOption> fieldOptions;

  SurveyField({
    required this.id,
    required this.name,
    this.description,
    this.placeholder,
    required this.type,
    required this.isRequired,
    required this.isUnique,
    required this.fieldOptions,
  });

  factory SurveyField.fromJson(Map<String, dynamic> json) =>
      _$SurveyFieldFromJson(json);
}

@JsonSerializable()
class FieldOption {
  final String name;

  FieldOption({required this.name});

  factory FieldOption.fromJson(Map<String, dynamic> json) =>
      _$FieldOptionFromJson(json);
}
