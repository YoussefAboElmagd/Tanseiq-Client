import 'package:json_annotation/json_annotation.dart';

part 'check_package_response.g.dart';

@JsonSerializable()
class CheckPackageResponse {
  final bool isError;
  final String? message;

  CheckPackageResponse({required this.isError, this.message});

  factory CheckPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPackageResponseFromJson(json);
}
