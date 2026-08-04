import 'package:json_annotation/json_annotation.dart';

part 'get_camp_details_response.g.dart';

@JsonSerializable()
class GetCampDetailsResponse {
  final String? campNumber;
  final String? campPhoto;
  final dynamic housingArea;
  final int? campArea;
  final int? companiesCount;
  final bool? isRented;
  final double? completionPercentage;
  final String? generatorStatus;
  final int? generatorStatusCode;
  final int? completionStatusCode;
  final String? completionStatus;
  final String? nationality;
  final int? kitchenNumber;
  final int? numberOfHajj;
  final String? zone;
  final int? zoneId;
  final String? company;
  final int? companyId;
  final String? squareNumber;
  final int? squareId;
  final int? campWorkScore;
  final int? id;
  final String? modifierName;
  final String? modifiedDate;
  final double? lat;
  final double? lng;

  GetCampDetailsResponse({
    this.campNumber,
    this.campPhoto,
    this.housingArea,
    this.campArea,
    this.companiesCount,
    this.isRented,
    this.completionPercentage,
    this.generatorStatus,
    this.generatorStatusCode,
    this.completionStatusCode,
    this.completionStatus,
    this.nationality,
    this.kitchenNumber,
    this.numberOfHajj,
    this.zone,
    this.zoneId,
    this.company,
    this.companyId,
    this.squareNumber,
    this.squareId,
    this.campWorkScore,
    this.id,
    this.modifierName,
    this.modifiedDate,
    this.lat,
    this.lng,
  });

  factory GetCampDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCampDetailsResponseFromJson(json);
}
