import 'package:json_annotation/json_annotation.dart';

part 'get_generators_serials_response.g.dart';

@JsonSerializable()
class GetGeneratorsSerialsResponse {
  final int id;
  @JsonKey(name: 'serialNumber')
  final String? name;

  GetGeneratorsSerialsResponse({required this.id, this.name});

  factory GetGeneratorsSerialsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGeneratorsSerialsResponseFromJson(json);
}
