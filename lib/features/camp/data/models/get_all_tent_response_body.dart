import 'package:json_annotation/json_annotation.dart';

part 'get_all_tent_response_body.g.dart';

@JsonSerializable()
class GetAllTentResponseBody {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool? hasPrevious;
  bool hasNext;
  @JsonKey(name: 'data')
  final List<TentData> tents;

  GetAllTentResponseBody({
    required this.tents,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory GetAllTentResponseBody.fromJson(Map<String, dynamic> json) =>
      _$GetAllTentResponseBodyFromJson(json);
}

@JsonSerializable()
class TentData {
  final String? campNumber;
  final String? campPhoto;
  final String? allocationStatus;
  final String? nationality;
  final String? addressInfo;
  final String? completionStatus;
  final String? transportation;
  final String? requestAdditionsDate;
  final String? addonLicenseReceiptDate;
  final String? startDate;
  final String? finalDate;
  final String? zone;
  final String? company;
  final String? category;
  final String? minorCompany;
  final String? consultant;
  final String? contractorUser;
  final String? developerCompany;
  final String? tentArea;
  final String? squareNumber;
  final String? rejectedRentalApplication;
  final String? deleterName;
  final String? deletedDate;
  final String? updateDate;
  final String? updaterName;
  final String? modifierName;
  final String? modifiedDate;
  final String? serviceCenterNumber;
  final String? serviceCenterHeadName;
  final int? campArea;
  final int? housingPercentage;
  final int? companiesCount;
  final int? completionPercentage;
  final int? allocationStatusCode;
  final int? completionStatusCode;
  final int? kitchenNumber;
  final int? numberOfCollectionToilets;
  final int? housingArea;
  final int? numberOfToilets;
  final int? numberOfHajjToilet;
  final int? numberOfHajj;
  final String? serviceCenterHeadPhone;
  final String? additionsOrderNumber;
  final int? zoneId;
  final dynamic phaseId;
  final dynamic phase;
  final dynamic packageId;
  final dynamic companyId;
  final dynamic categoryId;
  final dynamic minorCompanyId;
  final dynamic consultantId;
  final dynamic contractorUserId;
  final dynamic developerCompanyId;
  final dynamic tentAreaId;
  final dynamic squareId;
  final dynamic rejectedRentalApplicationId;
  final dynamic orderId;
  final dynamic orderNumber;
  final dynamic objectId;
  final dynamic countOfTents;
  final dynamic averageBuildingScore;
  final dynamic averagePreparingScore;
  final dynamic campWorkScore;
  final dynamic electricalCampScore;
  final dynamic campAdditionScore;
  final dynamic id;
  final dynamic package;
  final dynamic globalId;
  final dynamic lat;
  final dynamic lng;
  final bool? isRented;
  final bool? isIdentical;
  final bool? addonLicense;
  final bool? isDeleted;

  TentData({
    this.campNumber,
    this.campPhoto,
    this.housingArea,
    this.allocationStatus,
    this.nationality,
    this.addressInfo,
    this.completionStatus,
    this.transportation,
    this.requestAdditionsDate,
    this.addonLicenseReceiptDate,
    this.startDate,
    this.finalDate,
    this.zone,
    this.company,
    this.category,
    this.minorCompany,
    this.consultant,
    this.contractorUser,
    this.developerCompany,
    this.tentArea,
    this.squareNumber,
    this.rejectedRentalApplication,
    this.deleterName,
    this.deletedDate,
    this.updateDate,
    this.updaterName,
    this.modifierName,
    this.modifiedDate,
    this.campArea,
    this.housingPercentage,
    this.companiesCount,
    this.completionPercentage,
    this.allocationStatusCode,
    this.completionStatusCode,
    this.kitchenNumber,
    this.numberOfCollectionToilets,
    this.numberOfToilets,
    this.numberOfHajjToilet,
    this.numberOfHajj,
    this.serviceCenterNumber,
    this.serviceCenterHeadName,
    this.serviceCenterHeadPhone,
    this.additionsOrderNumber,
    this.zoneId,
    this.phaseId,
    this.phase,
    this.packageId,
    this.companyId,
    this.categoryId,
    this.minorCompanyId,
    this.consultantId,
    this.contractorUserId,
    this.developerCompanyId,
    this.tentAreaId,
    this.squareId,
    this.rejectedRentalApplicationId,
    this.orderId,
    this.orderNumber,
    this.objectId,
    this.countOfTents,
    this.averageBuildingScore,
    this.averagePreparingScore,
    this.campWorkScore,
    this.campAdditionScore,
    this.id,
    this.package,
    this.globalId,
    this.lat,
    this.lng,
    this.isRented,
    this.isIdentical,
    this.addonLicense,
    this.isDeleted,
    this.electricalCampScore,
  });

  factory TentData.fromJson(Map<String, dynamic> json) =>
      _$TentDataFromJson(json);
}
