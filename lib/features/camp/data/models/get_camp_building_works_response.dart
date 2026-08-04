import 'package:json_annotation/json_annotation.dart';

part 'get_camp_building_works_response.g.dart';

@JsonSerializable()
class GetCampBuildingWorksResponse {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final List<GetCampBuildingWorksData> data;

  GetCampBuildingWorksResponse({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory GetCampBuildingWorksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCampBuildingWorksResponseFromJson(json);
}

@JsonSerializable()
class GetCampBuildingWorksData {
  bool supply;
  bool structure;
  final String notes;
  final int tentId;
  final int id;
  final String nameLocalized;
  final String name;

  GetCampBuildingWorksData({
    required this.supply,
    required this.structure,
    required this.notes,
    required this.tentId,
    required this.id,
    required this.nameLocalized,
    required this.name,
  });

  factory GetCampBuildingWorksData.fromJson(Map<String, dynamic> json) =>
      _$GetCampBuildingWorksDataFromJson(json);
}
