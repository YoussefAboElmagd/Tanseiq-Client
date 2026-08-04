import 'package:json_annotation/json_annotation.dart';

part 'get_complains_types.g.dart';

@JsonSerializable()
class GetComplainsTypes {
  final int id;
  final String name;

  GetComplainsTypes({required this.id, required this.name});
  factory GetComplainsTypes.fromJson(Map<String, dynamic> json) =>
      _$GetComplainsTypesFromJson(json);
  Map<String, dynamic> toJson() => _$GetComplainsTypesToJson(this);
}
