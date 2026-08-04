import 'package:json_annotation/json_annotation.dart';

part 'get_camp_building_preparing_works_request.g.dart';

@JsonSerializable()
class GetCampBuildingPreparingWorksRequest {
  final int page;
  final int pageSize;
  final int campId;
  final int tentId;
  GetCampBuildingPreparingWorksRequest({
    required this.page,
    required this.pageSize,
    required this.campId,
    required this.tentId,
  });

  factory GetCampBuildingPreparingWorksRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCampBuildingPreparingWorksRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCampBuildingPreparingWorksRequestToJson(this);
}
