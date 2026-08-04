import 'package:json_annotation/json_annotation.dart';

part 'get_developer_company_response.g.dart';

@JsonSerializable()
class GetDeveloperCompanyResponse {
  final int id;
  final String name;

  GetDeveloperCompanyResponse(this.id, this.name);
  factory GetDeveloperCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDeveloperCompanyResponseFromJson(json);
}
