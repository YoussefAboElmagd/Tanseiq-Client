import 'package:json_annotation/json_annotation.dart';

part 'water_note_type_model.g.dart';

@JsonSerializable()
class WaterNoteTypeModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  WaterNoteTypeModel({this.id, this.name});

  factory WaterNoteTypeModel.fromJson(Map<String, dynamic> json) =>
      _$WaterNoteTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaterNoteTypeModelToJson(this);
}
