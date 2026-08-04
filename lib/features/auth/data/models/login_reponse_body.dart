import 'package:json_annotation/json_annotation.dart';

part 'login_reponse_body.g.dart';

@JsonSerializable()
class LoginReponseBody {
  final String? token;
  final String? route;
  final int? userId;
  final String? userName;
  final String? userType;
  final List<String?>? roles;
  final bool isError;
  final String? message;
  final int? targetId;
  final int? companyId;
  final dynamic returnedValue;

  LoginReponseBody({
    this.companyId,
    required this.token,
    this.route,
    this.userId,
    this.userName,
    this.userType,
    this.roles,
    required this.isError,
    required this.message,
    required this.targetId,
    required this.returnedValue,
  });

  factory LoginReponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginReponseBodyFromJson(json);
}
