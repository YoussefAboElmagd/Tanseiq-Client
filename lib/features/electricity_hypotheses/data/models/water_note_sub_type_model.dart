import 'package:json_annotation/json_annotation.dart';

part 'water_note_sub_type_model.g.dart';

@JsonSerializable()
class WaterNoteSubTypeModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'noteTypeId')
  int? noteTypeId;

  WaterNoteSubTypeModel({this.id, this.name, this.noteTypeId});

  factory WaterNoteSubTypeModel.fromJson(Map<String, dynamic> json) =>
      _$WaterNoteSubTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaterNoteSubTypeModelToJson(this);
}
