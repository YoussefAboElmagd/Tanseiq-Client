import 'package:json_annotation/json_annotation.dart';

part 'electric_zone_model.g.dart';

@JsonSerializable()
class ElectricZoneModel {
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

  ElectricZoneModel({
    this.id,
    this.name,
    this.nameLocalized,
    this.value,
    this.parentId,
    this.isEnd,
    this.orderInList,
  });

  factory ElectricZoneModel.fromJson(Map<String, dynamic> json) =>
      _$ElectricZoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$ElectricZoneModelToJson(this);
}
