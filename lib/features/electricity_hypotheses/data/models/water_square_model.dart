import 'package:json_annotation/json_annotation.dart';

part 'water_square_model.g.dart';

@JsonSerializable()
class WaterSquareModel {
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

  WaterSquareModel({
    this.id,
    this.name,
    this.nameLocalized,
    this.value,
    this.parentId,
    this.isEnd,
    this.orderInList,
  });

  factory WaterSquareModel.fromJson(Map<String, dynamic> json) =>
      _$WaterSquareModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaterSquareModelToJson(this);
}
