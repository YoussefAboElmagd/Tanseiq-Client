import 'package:json_annotation/json_annotation.dart';

part 'get_camp_analysis_reponse.g.dart';

@JsonSerializable()
class GetCampAnalysisReponse {
  final String? logo;
  final String? companyName;
  final dynamic totalCompletionPercentage;
  final dynamic totalNumberOfCamps;
  final dynamic totalCompletionPercentageBasedOnArafat;
  final dynamic totalNumberOfCampsBasedOnArafat;
  final dynamic totalCompletionPercentageBasedOnMina;
  final dynamic totalNumberOfCampsBasedOnMina;

  GetCampAnalysisReponse({
    this.logo,
    this.companyName,
    this.totalCompletionPercentage,
    this.totalNumberOfCamps,
    this.totalCompletionPercentageBasedOnArafat,
    this.totalNumberOfCampsBasedOnArafat,
    this.totalCompletionPercentageBasedOnMina,
    this.totalNumberOfCampsBasedOnMina,
  });

  factory GetCampAnalysisReponse.fromJson(Map<String, dynamic> json) =>
      _$GetCampAnalysisReponseFromJson(json);
}
