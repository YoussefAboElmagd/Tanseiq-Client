import 'package:json_annotation/json_annotation.dart';

part 'add_electric_hypothesis_request.g.dart';

@JsonSerializable()
class AddElectricHypothesisRequest {
  @JsonKey(name: 'SquareId')
  int? squareId;

  @JsonKey(name: 'CampId')
  int? campId;

  @JsonKey(name: 'IsPowerOutage')
  bool? isPowerOutage;

  @JsonKey(name: 'KedanaProblemNumber')
  String? kedanaProblemNumber;

  // Water Boilers (waterPumps)
  @JsonKey(name: 'IsAllWaterBoilersOn')
  bool? isAllWaterBoilersOn;
  @JsonKey(name: 'RunningBoilerCount')
  int? runningBoilerCount;
  @JsonKey(name: 'TotalBoilerCount')
  int? totalBoilerCount;
  @JsonKey(name: 'BoilerDetails')
  String? boilerDetails;
  @JsonKey(name: 'BoilerkadanasReportNumber')
  String? boilerkadanasReportNumber;
  @JsonKey(name: 'BoilerImagesFile')
  List<String>? boilerImagesFile;

  // Refrigerators (lamps)
  @JsonKey(name: 'IsAllRefrigeratorsOn')
  bool? isAllRefrigeratorsOn;
  @JsonKey(name: 'RunningFridgeCount')
  int? runningFridgeCount;
  @JsonKey(name: 'TotalFridgeCount')
  int? totalFridgeCount;
  @JsonKey(name: 'FridgeDetails')
  String? fridgeDetails;
  @JsonKey(name: 'FridgekadanasReportNumber')
  String? fridgekadanasReportNumber;
  @JsonKey(name: 'FridgeImagesFile')
  List<String>? fridgeImagesFile;

  // Lighting
  @JsonKey(name: 'IsAllLightingOn')
  bool? isAllLightingOn;
  @JsonKey(name: 'RunningLightingCount')
  int? runningLightingCount;
  @JsonKey(name: 'TotalLightingCount')
  int? totalLightingCount;
  @JsonKey(name: 'LightingDetails')
  String? lightingDetails;
  @JsonKey(name: 'LightingkadanasReportNumber')
  String? lightingkadanasReportNumber;
  @JsonKey(name: 'LightingImagesFiles')
  List<String>? lightingImagesFiles;

  // Air Conditioners
  @JsonKey(name: 'IsAllAirConditionersOn')
  bool? isAllAirConditionersOn;
  @JsonKey(name: 'RunningAirConditionerCount')
  int? runningAirConditionerCount;
  @JsonKey(name: 'TotalAirConditionerCount')
  int? totalAirConditionerCount;
  @JsonKey(name: 'AirConditionerDetails')
  String? airConditionerDetails;
  @JsonKey(name: 'AirConditionerkadanasReportNumber')
  String? airConditionerkadanasReportNumber;
  @JsonKey(name: 'AirConditionerImagesFiles')
  List<String>? airConditionerImagesFiles;

  // Electric Ovens
  @JsonKey(name: 'IsAllElectricOvensOn')
  bool? isAllElectricOvensOn;
  @JsonKey(name: 'RunningElectricOvenCount')
  int? runningElectricOvenCount;
  @JsonKey(name: 'TotalElectricOvenCount')
  int? totalElectricOvenCount;
  @JsonKey(name: 'ElectricOvenDetails')
  String? electricOvenDetails;
  @JsonKey(name: 'ElectricOvenkadanasReportNumber')
  String? electricOvenkadanasReportNumber;
  @JsonKey(name: 'ElectricOvenImagesFiles')
  List<String>? electricOvenImagesFiles;

  // Fans
  @JsonKey(name: 'IsFansOn')
  bool? isFansOn;
  @JsonKey(name: 'RunningFansCount')
  int? runningFansCount;
  @JsonKey(name: 'TotalFansCount')
  int? totalFansCount;
  @JsonKey(name: 'FansDetails')
  String? fansDetails;
  @JsonKey(name: 'FansKadanasReportNumber')
  String? fansKadanasReportNumber;
  @JsonKey(name: 'FansImagesFiles')
  List<String>? fansImagesFiles;

  // Freezers
  @JsonKey(name: 'IsFreezersOn')
  bool? isFreezersOn;
  @JsonKey(name: 'RunningFreezersCount')
  int? runningFreezersCount;
  @JsonKey(name: 'TotalFreezersCount')
  int? totalFreezersCount;
  @JsonKey(name: 'FreezersDetails')
  String? freezersDetails;
  @JsonKey(name: 'FreezersKadanasReportNumber')
  String? freezersKadanasReportNumber;
  @JsonKey(name: 'FreezersImagesFiles')
  List<String>? freezersImagesFiles;

  // Plugs
  @JsonKey(name: 'IsPlugsOn')
  bool? isPlugsOn;
  @JsonKey(name: 'RunningPlugsCount')
  int? runningPlugsCount;
  @JsonKey(name: 'TotalPlugsCount')
  int? totalPlugsCount;
  @JsonKey(name: 'PlugsDetails')
  String? plugsDetails;
  @JsonKey(name: 'PlugsKadanasReportNumber')
  String? plugsKadanasReportNumber;
  @JsonKey(name: 'PlugsImagesFiles')
  List<String>? plugsImagesFiles;

  AddElectricHypothesisRequest({
    this.squareId,
    this.campId,
    this.isPowerOutage,
    this.kedanaProblemNumber,
    this.isAllWaterBoilersOn,
    this.runningBoilerCount,
    this.totalBoilerCount,
    this.boilerDetails,
    this.boilerkadanasReportNumber,
    this.boilerImagesFile,
    this.isAllRefrigeratorsOn,
    this.runningFridgeCount,
    this.totalFridgeCount,
    this.fridgeDetails,
    this.fridgekadanasReportNumber,
    this.fridgeImagesFile,
    this.isAllLightingOn,
    this.runningLightingCount,
    this.totalLightingCount,
    this.lightingDetails,
    this.lightingkadanasReportNumber,
    this.lightingImagesFiles,
    this.isAllAirConditionersOn,
    this.runningAirConditionerCount,
    this.totalAirConditionerCount,
    this.airConditionerDetails,
    this.airConditionerkadanasReportNumber,
    this.airConditionerImagesFiles,
    this.isAllElectricOvensOn,
    this.runningElectricOvenCount,
    this.totalElectricOvenCount,
    this.electricOvenDetails,
    this.electricOvenkadanasReportNumber,
    this.electricOvenImagesFiles,
    this.isFansOn,
    this.runningFansCount,
    this.totalFansCount,
    this.fansDetails,
    this.fansKadanasReportNumber,
    this.fansImagesFiles,
    this.isFreezersOn,
    this.runningFreezersCount,
    this.totalFreezersCount,
    this.freezersDetails,
    this.freezersKadanasReportNumber,
    this.freezersImagesFiles,
    this.isPlugsOn,
    this.runningPlugsCount,
    this.totalPlugsCount,
    this.plugsDetails,
    this.plugsKadanasReportNumber,
    this.plugsImagesFiles,
  });

  factory AddElectricHypothesisRequest.fromJson(Map<String, dynamic> json) =>
      _$AddElectricHypothesisRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddElectricHypothesisRequestToJson(this);
}
