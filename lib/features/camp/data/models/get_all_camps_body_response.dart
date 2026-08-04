import 'package:json_annotation/json_annotation.dart';

part 'get_all_camps_body_response.g.dart';

@JsonSerializable()
class GetAllCampsBodyResponse {
  final int id;
  final String campNumber;
  final bool? isRented;
  final int kitchenNumber;
  final int numberOfCollectionToilets;
  final int numberOfToilets;
  final int numberOfHajjToilet;
  final double lat;
  final double lng;
  final int squareId;
  final String squareNumber;

  GetAllCampsBodyResponse({
    required this.id,
    required this.campNumber,
    this.isRented,
    required this.kitchenNumber,
    required this.numberOfCollectionToilets,
    required this.numberOfToilets,
    required this.numberOfHajjToilet,
    required this.lat,
    required this.lng,
    required this.squareId,
    required this.squareNumber,
  });

  factory GetAllCampsBodyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCampsBodyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCampsBodyResponseToJson(this);
}
