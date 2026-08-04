import 'package:json_annotation/json_annotation.dart';

part 'water_camp_model.g.dart';

@JsonSerializable()
class WaterCampModel {
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

  WaterCampModel({
    this.id,
    this.name,
    this.nameLocalized,
    this.value,
    this.parentId,
    this.isEnd,
    this.orderInList,
  });

  factory WaterCampModel.fromJson(Map<String, dynamic> json) =>
      _$WaterCampModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaterCampModelToJson(this);
}
