import 'package:json_annotation/json_annotation.dart';

part 'get_map_points.g.dart';

@JsonSerializable()
class GetMapPoints {
  final int? zoneId;
  final dynamic zoneCode;
  final String? zone;
  final String? serialNumber;
  final String? longitude;
  final String? latitude;
  final int? ability;
  final int? lowAbility;
  final int? meduimAbility;
  final int? highAbility;
  final String? status;
  final int? statusCode;
  final String? updaterName;
  final String? updateDate;
  final String? creatorName;
  final String? createDate;
  final bool? isDeleted;
  final String? deleterName;
  final String? deletedDate;
  final String? modifierName;
  final String? modifiedDate;
  final String? serviceCompany;
  final int? serviceCompanyId;
  final int? supervisorId;
  final String? supervisor;
  final int? developerCompanyId;
  final String? developerCompany;
  final int? id;

  GetMapPoints({
    this.zoneId,
    this.zoneCode,
    required this.zone,
    this.serialNumber,
    this.longitude,
    this.latitude,
    this.ability,
    this.lowAbility,
    this.meduimAbility,
    this.highAbility,
    this.status,
    this.statusCode,
    this.developerCompanyId,
    this.updaterName,
    this.updateDate,
    this.creatorName,
    this.createDate,
    this.isDeleted,
    this.deleterName,
    this.deletedDate,
    this.modifierName,
    this.modifiedDate,
    this.serviceCompany,
    this.serviceCompanyId,
    this.supervisorId,
    this.supervisor,
    this.developerCompany,
    this.id,
  });

  factory GetMapPoints.fromJson(Map<String, dynamic> json) =>
      _$GetMapPointsFromJson(json);
}
