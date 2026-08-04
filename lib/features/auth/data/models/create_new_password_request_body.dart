import 'package:json_annotation/json_annotation.dart';

part 'create_new_password_request_body.g.dart';

@JsonSerializable()
class CreateNewPasswordRequestBody {
  final String email;
  final String password;
  final String confirmPassword;

  CreateNewPasswordRequestBody({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory CreateNewPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateNewPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewPasswordRequestBodyToJson(this);
}
