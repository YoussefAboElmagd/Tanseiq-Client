import 'package:json_annotation/json_annotation.dart';

part 'get_all_camps_dimension_response.g.dart';

@JsonSerializable()
class GetAllCampsDimensionResponse {
  final int id;
  final double lat;
  final double lng;
  final String campNumber;

  GetAllCampsDimensionResponse({
    required this.id,
    required this.lat,
    required this.lng,
    required this.campNumber,
  });

  factory GetAllCampsDimensionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCampsDimensionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCampsDimensionResponseToJson(this);
}
