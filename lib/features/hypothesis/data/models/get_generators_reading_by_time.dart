import 'package:json_annotation/json_annotation.dart';

part 'get_generators_reading_by_time.g.dart';

@JsonSerializable()
class GetGeneratorsReadingByTime {
  String? generatorSerial;
  List<ReadingData>? readings;

  GetGeneratorsReadingByTime({this.generatorSerial, this.readings});

  factory GetGeneratorsReadingByTime.fromJson(Map<String, dynamic> json) =>
      _$GetGeneratorsReadingByTimeFromJson(json);
  Map<String, dynamic> toJson() => _$GetGeneratorsReadingByTimeToJson(this);
}

@JsonSerializable()
class ReadingData {
  int? id;
  int? generatorId;
  String? date;
  String? time;
  double? currentR;
  double? currentY;
  double? currentB;

  ReadingData({
    this.id,
    this.generatorId,
    this.date,
    this.time,
    this.currentR,
    this.currentY,
    this.currentB,
  });

  factory ReadingData.fromJson(Map<String, dynamic> json) =>
      _$ReadingDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingDataToJson(this);
}

// {
//     "generatorSerial": "244",
//     "readings": [
//       {
//         "id": 11,
//         "generatorId": 2,
//         "date": "2025-04-23",
//         "time": "11:59AM",
//         "currentR": 10,
//         "currentY": 10,
//         "currentB": 10
//       },
//       {
//         "id": 12,
//         "generatorId": 2,
//         "date": "2025-04-23",
//         "time": "11:59AM",
//         "currentR": 10,
//         "currentY": 10,
//         "currentB": 10
//       }
//     ]
//   }
