import 'package:json_annotation/json_annotation.dart';

part 'get_camp_details_request_body.g.dart';

@JsonSerializable()
class GetCampDetailsRequestBody {
  final String page;
  final String pageSize;
  @JsonKey(name: 'CampId')
  final String campId;

  GetCampDetailsRequestBody({
    required this.page,
    required this.pageSize,
    required this.campId,
  });

  factory GetCampDetailsRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetCampDetailsRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GetCampDetailsRequestBodyToJson(this);
}
