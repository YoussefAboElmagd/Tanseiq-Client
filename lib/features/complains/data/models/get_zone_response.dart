import 'package:json_annotation/json_annotation.dart';

part 'get_zone_response.g.dart';

@JsonSerializable()
class GetZoneResponse {
  final int id;
  final String name;

  GetZoneResponse({required this.id, required this.name});

  factory GetZoneResponse.fromJson(Map<String, dynamic> json) =>
      _$GetZoneResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetZoneResponseToJson(this);
}
