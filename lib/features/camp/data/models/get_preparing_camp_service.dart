import 'package:json_annotation/json_annotation.dart';

part 'get_preparing_camp_service.g.dart';

@JsonSerializable()
class GetPreparingCampService {
  final TentMetaData tentMetaData;
  final TentServices tentServices;

  GetPreparingCampService({
    required this.tentMetaData,
    required this.tentServices,
  });

  factory GetPreparingCampService.fromJson(Map<String, dynamic> json) =>
      _$GetPreparingCampServiceFromJson(json);
}

@JsonSerializable()
class TentMetaData {
  final String? tentStatus;
  final String? tentNumber;
  final String? completionPercentage;

  TentMetaData({this.tentStatus, this.tentNumber, this.completionPercentage});

  factory TentMetaData.fromJson(Map<String, dynamic> json) =>
      _$TentMetaDataFromJson(json);
}

@JsonSerializable()
class TentServices {
  final String? tentArea;
  final String? squareNumber;
  final String? tentService;

  TentServices({this.tentArea, this.squareNumber, this.tentService});

  factory TentServices.fromJson(Map<String, dynamic> json) =>
      _$TentServicesFromJson(json);
}
