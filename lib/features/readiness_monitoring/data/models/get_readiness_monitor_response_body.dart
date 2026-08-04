import 'package:json_annotation/json_annotation.dart';

part 'get_readiness_monitor_response_body.g.dart';

@JsonSerializable()
class GetReadinessMonitorResponseBody {
  final MapData map;
  GetReadinessMonitorResponseBody({required this.map});

  factory GetReadinessMonitorResponseBody.fromJson(Map<String, dynamic> json) =>
      _$GetReadinessMonitorResponseBodyFromJson(json);
}

@JsonSerializable()
class MapData {
  final String? hajjNumber;
  final String? zoneArea;
  final int? numberOfTents;
  final dynamic locations;
  final List<Zone>? zones;
  MapData({
    this.hajjNumber,
    this.zoneArea,
    this.numberOfTents,
    this.locations,
    required this.zones,
  });
  factory MapData.fromJson(Map<String, dynamic> json) =>
      _$MapDataFromJson(json);
}

@JsonSerializable()
class Zone {
  final int? id;
  final String? name;
  final String? value;
  final int? parentId;
  final bool? isEnd;
  final int? orderInList;
  Zone({
    this.id,
    this.name,
    this.value,
    this.parentId,
    this.isEnd,
    this.orderInList,
  });
  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
}
