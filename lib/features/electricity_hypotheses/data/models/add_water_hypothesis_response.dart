import 'package:json_annotation/json_annotation.dart';

part 'add_water_hypothesis_response.g.dart';

@JsonSerializable()
class AddWaterHypothesisResponse {
  @JsonKey(name: 'isError')
  bool? isError;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'errors')
  dynamic errors;

  AddWaterHypothesisResponse({this.isError, this.message, this.errors});

  factory AddWaterHypothesisResponse.fromJson(Map<String, dynamic> json) =>
      _$AddWaterHypothesisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddWaterHypothesisResponseToJson(this);
}
