import 'package:json_annotation/json_annotation.dart';

part 'get_drop_down_filter_response.g.dart';

@JsonSerializable()
class GetDropDownFilterResponse {
  final dynamic id;
  final String name;

  GetDropDownFilterResponse({required this.id, required this.name});

  factory GetDropDownFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDropDownFilterResponseFromJson(json);
}
