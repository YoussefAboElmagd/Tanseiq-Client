import 'package:json_annotation/json_annotation.dart';

part 'post_preparing_request_body.g.dart';

@JsonSerializable()
class PostPreparingRequestBody {
  final int unit;
  final int suppliedQuantity;
  final int implementedQuantity;
  final int remaining;
  final String notes;
  final int? tentId;
  final String? tent;

  PostPreparingRequestBody({
    required this.unit,
    required this.suppliedQuantity,
    required this.implementedQuantity,
    required this.remaining,
    required this.notes,
    required this.tentId,
    this.tent,
  });

  factory PostPreparingRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PostPreparingRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$PostPreparingRequestBodyToJson(this);
}
