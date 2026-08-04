import 'package:json_annotation/json_annotation.dart';

part 'get_all_tent_request_body.g.dart';

@JsonSerializable()
class GetAllTentRequestBody {
  final int page;
  final int pageSize;
  final int companyId;
  final int developerId;
  final String? zone;
  final String? campNumber;

  GetAllTentRequestBody({
    required this.page,
    required this.pageSize,
    required this.companyId,
    this.zone,
    this.campNumber,
    required this.developerId,
  });

  factory GetAllTentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetAllTentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTentRequestBodyToJson(this);
}
