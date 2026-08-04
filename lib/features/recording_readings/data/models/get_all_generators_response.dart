import 'package:json_annotation/json_annotation.dart';

part 'get_all_generators_response.g.dart';

@JsonSerializable()
class GetAllGeneratorsResponse {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final List<GeneratorsData> data;

  GetAllGeneratorsResponse({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.data,
  });

  factory GetAllGeneratorsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllGeneratorsResponseFromJson(json);
}

@JsonSerializable()
class GeneratorsData {
  final int? zoneId;
  final String? zone;
  final int? generatorId;
  final String? generator;
  final String? time;
  final double? currentR;
  final double? currentY;
  final double? currentB;
  final double? currentRPercentage;
  final double? currentYPercentage;
  final double? currentBPercentage;
  final String? currentRStatus;
  final int? currentRStatusCode;
  final String? currentYStatus;
  final int? currentYStatusCode;
  final String? currentBStatus;
  final int? currentBStatusCode;
  final String? imageUrl;
  final String? image;
  final int? id;
  final bool? isDeleted;
  final String? deleterName;
  final String? deletedDate;
  final String? updaterName;
  final String? updateDate;
  final String? modifierName;
  final String? modifiedDate;

  GeneratorsData({
    required this.zoneId,
    required this.zone,
    required this.generatorId,
    required this.generator,
    required this.time,
    required this.currentR,
    required this.currentY,
    required this.currentB,
    required this.currentRPercentage,
    required this.currentYPercentage,
    required this.currentBPercentage,
    required this.currentRStatus,
    required this.currentRStatusCode,
    required this.currentYStatus,
    required this.currentYStatusCode,
    required this.currentBStatus,
    required this.currentBStatusCode,
    required this.imageUrl,
    required this.image,
    required this.id,
    required this.isDeleted,
    required this.deleterName,
    required this.deletedDate,
    required this.updaterName,
    required this.updateDate,
    required this.modifierName,
    required this.modifiedDate,
  });

  factory GeneratorsData.fromJson(Map<String, dynamic> json) =>
      _$GeneratorsDataFromJson(json);
}
