import 'package:json_annotation/json_annotation.dart';

part 'get_all_complains_response.g.dart';

@JsonSerializable()
class GetAllComplainsResponse {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  @JsonKey(name: 'data')
  final List<ComplainsData> complainsData;

  GetAllComplainsResponse({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.complainsData,
  });

  factory GetAllComplainsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllComplainsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllComplainsResponseToJson(this);
}

@JsonSerializable()
class ComplainsData {
  final String? address;
  final String? description;
  final String? reporterName;
  final String? phoneNumber;
  final String? statusCode;
  final String? date;
  final String? streetNumber;
  final String? centerNumber;
  final String? nationality;
  final String? deleterName;
  final String? deletedDate;
  final String? updaterName;
  final String? updateDate;
  final String? modifierName;
  final String? modifiedDate;
  final int? problemTypeCode;
  final int? problemStatusCode;
  final int? id;
  final int? squareId;
  final dynamic square;
  final int? campId;
  final dynamic camp;
  final int? gateId;
  final dynamic gate;
  final int? zoneId;
  final dynamic zone;
  final dynamic problemType;
  final dynamic location;
  final List<ProblemMediaData>? problemMedia;
  final bool? isDeleted;

  ComplainsData({
    this.address,
    this.camp,
    this.campId,
    this.centerNumber,
    this.date,
    this.deletedDate,
    this.deleterName,
    this.description,
    this.gate,
    this.gateId,
    this.id,
    this.isDeleted,
    this.location,
    this.modifiedDate,
    this.nationality,
    this.modifierName,
    this.phoneNumber,
    this.problemMedia,
    this.problemStatusCode,
    this.problemType,
    this.problemTypeCode,
    this.reporterName,
    this.square,
    this.squareId,
    this.statusCode,
    this.streetNumber,
    this.updateDate,
    this.updaterName,
    this.zone,
    this.zoneId,
  });

  factory ComplainsData.fromJson(Map<String, dynamic> json) =>
      _$ComplainsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ComplainsDataToJson(this);
}

@JsonSerializable()
class ProblemMediaData {
  final String? path;

  ProblemMediaData({this.path});

  factory ProblemMediaData.fromJson(Map<String, dynamic> json) =>
      _$ProblemMediaDataFromJson(json);
}
