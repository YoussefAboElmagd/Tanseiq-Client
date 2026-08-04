import 'package:json_annotation/json_annotation.dart';

part 'add_water_hypothesis_request.g.dart';

@JsonSerializable()
class AddWaterHypothesisRequest {
  @JsonKey(name: 'campId')
  int? campId;

  @JsonKey(name: 'Square')
  String? square;
  @JsonKey(name: 'Zone')
  String? zone;
  @JsonKey(name: 'Camp')
  String? camp;

  @JsonKey(name: 'HypothesisId')
  int? hypothesisId;

  @JsonKey(name: 'isThereIsANote')
  bool? isThereIsANote;

  @JsonKey(name: 'Notes')
  List<NoteRequest>? notes;

  AddWaterHypothesisRequest({
    this.campId,
    this.hypothesisId,
    this.isThereIsANote,
    this.notes,
    this.camp,
    this.square,
    this.zone,
  });

  factory AddWaterHypothesisRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWaterHypothesisRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddWaterHypothesisRequestToJson(this);
}

@JsonSerializable()
class NoteRequest {
  @JsonKey(name: 'hypothesisId')
  String? hypothesisId;

  @JsonKey(name: 'NoteType')
  int? noteType;

  @JsonKey(name: 'anotherDetails')
  String? anotherDetails;

  @JsonKey(name: 'NoteSubType')
  int? noteSubType;

  @JsonKey(name: 'nearestRestroomNumber')
  String? nearestRestroomNumber;

  @JsonKey(name: 'kadanasReportNumber')
  String? kadanasReportNumber;

  @JsonKey(name: 'CaseImages')
  List<String>? caseImages;

  @JsonKey(name: 'PlaceImages')
  List<String>? placeImages;

  NoteRequest({
    this.hypothesisId,
    this.noteType,
    this.anotherDetails,
    this.noteSubType,
    this.nearestRestroomNumber,
    this.kadanasReportNumber,
    this.caseImages,
    this.placeImages,
  });

  factory NoteRequest.fromJson(Map<String, dynamic> json) =>
      _$NoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NoteRequestToJson(this);
}
