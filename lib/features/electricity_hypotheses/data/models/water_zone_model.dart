import 'package:json_annotation/json_annotation.dart';

part 'water_zone_model.g.dart';

@JsonSerializable()
class WaterZoneModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nameLocalized')
  String? nameLocalized;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'parentId')
  int? parentId;

  @JsonKey(name: 'isEnd')
  bool? isEnd;

  @JsonKey(name: 'orderInList')
  int? orderInList;

  WaterZoneModel({
    this.id,
    this.name,
    this.nameLocalized,
    this.value,
    this.parentId,
    this.isEnd,
    this.orderInList,
  });

  factory WaterZoneModel.fromJson(Map<String, dynamic> json) =>
      _$WaterZoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaterZoneModelToJson(this);
}
