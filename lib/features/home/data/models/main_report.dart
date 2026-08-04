import 'package:json_annotation/json_annotation.dart';

part 'main_report.g.dart';

@JsonSerializable()
class MainReport {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'totalCount')
  int? totalCount;

  @JsonKey(name: 'problemTypes')
  List<ProblemType>? problemTypes;

  MainReport({this.status, this.totalCount, this.problemTypes});

  factory MainReport.fromJson(Map<String, dynamic> json) =>
      _$MainReportFromJson(json);

  Map<String, dynamic> toJson() => _$MainReportToJson(this);
}

@JsonSerializable()
class ProblemType {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'totalCount')
  int? totalCount;

  ProblemType({this.type, this.totalCount});

  factory ProblemType.fromJson(Map<String, dynamic> json) =>
      _$ProblemTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemTypeToJson(this);
}
