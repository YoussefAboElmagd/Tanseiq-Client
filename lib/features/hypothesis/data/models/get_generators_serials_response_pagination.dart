import 'package:json_annotation/json_annotation.dart';

part 'get_generators_serials_response_pagination.g.dart';

@JsonSerializable()
class GetGeneratorsSerialsResponsePagination {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  @JsonKey(name: 'data')
  final List<SerialsData> serialsData;

  GetGeneratorsSerialsResponsePagination({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.serialsData,
  });

  factory GetGeneratorsSerialsResponsePagination.fromJson(
    Map<String, dynamic> json,
  ) => _$GetGeneratorsSerialsResponsePaginationFromJson(json);
}

@JsonSerializable()
class SerialsData {
  final int id;
  @JsonKey(name: 'serialNumber')
  final String? name;

  SerialsData({required this.id, this.name});

  factory SerialsData.fromJson(Map<String, dynamic> json) =>
      _$SerialsDataFromJson(json);
}
