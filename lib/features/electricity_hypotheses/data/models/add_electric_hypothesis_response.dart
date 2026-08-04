import 'package:json_annotation/json_annotation.dart';

part 'add_electric_hypothesis_response.g.dart';

@JsonSerializable()
class AddElectricHypothesisResponse {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'isError')
  bool? isError;

  @JsonKey(name: 'success')
  bool? success;

  AddElectricHypothesisResponse({this.message, this.isError, this.success});

  factory AddElectricHypothesisResponse.fromJson(Map<String, dynamic> json) =>
      _$AddElectricHypothesisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddElectricHypothesisResponseToJson(this);
}
