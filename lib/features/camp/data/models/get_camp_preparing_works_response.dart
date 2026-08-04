import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_camp_preparing_works_response.g.dart';

@JsonSerializable()
class GetCampPreparingWorksResponse {
  final int? campId;
  final int? serviceItemId;
  final ServiceItem? serviceItem;
  final int? quantity;
  final int? suppliedQuantity;
  final int? executedQuantity;
  final int? remainingQuantity;
  final String? notes;
  final String? campWorkPhoto;
  final String? photoUrl;
  final int? completionRate;
  final int? compelationRate;
  @JsonKey(ignore: true)
  TextEditingController completionRateController = TextEditingController();
  @JsonKey(ignore: true)
  TextEditingController notesController = TextEditingController();
  final int? id;
  final bool? isDeleted;
  final String? name;
  final String? deleterName;
  final String? deletedDate;
  final String? updaterName;
  final String? updateDate;
  final String? modifierName;
  final String? modifiedDate;

  GetCampPreparingWorksResponse({
    required this.photoUrl,
    required this.compelationRate,
    required this.suppliedQuantity,
    required this.executedQuantity,
    required this.remainingQuantity,
    required this.campId,
    required this.serviceItemId,
    required this.name,
    this.serviceItem,
    required this.quantity,
    required this.notes,
    this.campWorkPhoto,
    this.completionRate,
    required this.id,
    required this.isDeleted,
    required this.deleterName,
    this.deletedDate,
    required this.updaterName,
    required this.updateDate,
    required this.modifierName,
    required this.modifiedDate,
  });

  factory GetCampPreparingWorksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCampPreparingWorksResponseFromJson(json);
}

@JsonSerializable()
class ServiceItem {
  final String? unit;
  final int? serviceCategoryId;
  final String? serviceCategory;
  final int? points;
  final String? description;
  final bool? isMena;
  final bool? isArafaat;
  final bool? isMozdalifa;
  final String? nameLocalized;
  final String? name;
  final int? id;
  final bool? isDeleted;
  final String? deleterName;
  final String? deletedDate;
  final String? updaterName;
  final String? updateDate;
  final String? modifierName;
  final String? modifiedDate;
  @JsonKey(ignore: true)
  TextEditingController suppliedQuantityController = TextEditingController();
  @JsonKey(ignore: true)
  TextEditingController implementedQuantityController = TextEditingController();

  ServiceItem({
    this.unit,
    this.serviceCategoryId,
    this.serviceCategory,
    this.points,
    this.description,
    this.isMena,
    this.isArafaat,
    this.isMozdalifa,
    this.nameLocalized,
    this.name,
    this.id,
    this.isDeleted,
    this.deleterName,
    this.deletedDate,
    this.updaterName,
    this.updateDate,
    this.modifierName,
    this.modifiedDate,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemFromJson(json);
}
