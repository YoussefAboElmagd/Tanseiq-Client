import 'package:json_annotation/json_annotation.dart';

part 'get_complain_option_types_response.g.dart';

@JsonSerializable()
class GetComplainOptionTypesResponse {
  final int id;
  final String name;

  GetComplainOptionTypesResponse({required this.id, required this.name});

  factory GetComplainOptionTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetComplainOptionTypesResponseFromJson(json);
}
