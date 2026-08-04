import 'package:json_annotation/json_annotation.dart';

part 'get_all_square_response.g.dart';

@JsonSerializable()
class GetAllSquareResponse {
  final int id;
  final String name;

  GetAllSquareResponse({required this.id, required this.name});

  factory GetAllSquareResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllSquareResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSquareResponseToJson(this);
}
