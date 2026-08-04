import 'package:json_annotation/json_annotation.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_preparing_works_response.dart';

part 'get_all_electrical_services.g.dart';

@JsonSerializable()
class GetAllElectricalServices {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;

  final List<GetCampPreparingWorksResponse> data;

  GetAllElectricalServices(
    this.currentPage,
    this.totalPages,
    this.pageSize,
    this.totalCount,
    this.hasPrevious,
    this.hasNext,
    this.data,
  );

  factory GetAllElectricalServices.fromJson(Map<String, dynamic> json) =>
      _$GetAllElectricalServicesFromJson(json);
}
