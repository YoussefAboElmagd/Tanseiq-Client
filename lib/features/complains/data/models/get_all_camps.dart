import 'package:json_annotation/json_annotation.dart';

part 'get_all_camps.g.dart';

@JsonSerializable()
class GetAllCamps {
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'nameLocalized')
  final String? nameLocalized;

  GetAllCamps({
    required this.id,
    required this.name,
    required this.nameLocalized,
  });

  factory GetAllCamps.fromJson(Map<String, dynamic> json) =>
      _$GetAllCampsFromJson(json);
}
