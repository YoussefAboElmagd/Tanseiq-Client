import 'package:json_annotation/json_annotation.dart';

part 'post_request_camp.g.dart';

@JsonSerializable()
class PostRequestCamp {
  final int id;
  final String campNumber;
  final int tentArea;
  final int housingArea;
  final bool isRented;
  final int kitchenNumber;
  final int numberOfCollectionToilets;
  final int numberOfToilets;
  final int numberOfHajjToilet;
  final double lat;
  final double lng;
  final int squareId;

  PostRequestCamp({
    required this.id,
    required this.campNumber,
    required this.tentArea,
    required this.housingArea,
    required this.isRented,
    required this.kitchenNumber,
    required this.numberOfCollectionToilets,
    required this.numberOfToilets,
    required this.numberOfHajjToilet,
    required this.lat,
    required this.lng,
    required this.squareId,
  });

  factory PostRequestCamp.fromJson(Map<String, dynamic> json) =>
      _$PostRequestCampFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestCampToJson(this);
}
