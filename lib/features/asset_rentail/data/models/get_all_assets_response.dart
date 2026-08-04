import 'package:json_annotation/json_annotation.dart';

part 'get_all_assets_response.g.dart';

@JsonSerializable()
class GetAllAssetsResponse {
  final int? currentPage;
  final int? pageSize;
  final int? totalPages;
  final int? totalCount;
  final bool hasNext;
  final List<GetAllAssetsResponseData> data;
  GetAllAssetsResponse({
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
    required this.hasNext,
    required this.data,
  });

  factory GetAllAssetsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllAssetsResponseFromJson(json);
}

@JsonSerializable()
class GetAllAssetsResponseData {
  final int? orderNumber;
  final dynamic rentedCompany;
  final String? statusAcception;
  final int? statusAcceptionCode;
  final int? hajjNumber;
  final int? tentArea;
  final String? nationality;
  final String? state;
  final int? stateCode;
  final dynamic orderComment;
  final int? normalTentQuantity;
  final String? normalTentUnit;
  final int? normalTentPrice;
  final int? pvcTentQuantity;
  final String? pvcTentUnit;
  final int? pvcTentPrice;
  final int? normalKicthenQuantity;
  final String? normalKicthenUnit;
  final int? normalKicthenPrice;
  final int? largeKicthenQuantity;
  final String? largeKicthenUnit;
  final int? largeKicthenPrice;
  final int? housingArea;
  final int? companyId;
  final String? company;
  final int? developCompanyId;
  final String? developCompany;
  final int? packageId;
  final String? package;
  final int? packagePrice;
  final int? id;
  final dynamic ministryAttachmentStateCode;
  final dynamic deliverySketchStateCode;
  final dynamic ministryAttachmentFile;
  final dynamic deliverySketchFile;
  final dynamic deliveryDate;
  final dynamic completionReport;
  final dynamic recieptReport;
  final dynamic reRecieve;
  final dynamic zone;

  GetAllAssetsResponseData({
    required this.orderNumber,
    required this.rentedCompany,
    required this.statusAcception,
    required this.statusAcceptionCode,
    required this.hajjNumber,
    required this.tentArea,
    required this.nationality,
    required this.state,
    required this.stateCode,
    required this.orderComment,
    required this.normalTentQuantity,
    required this.normalTentUnit,
    required this.normalTentPrice,
    required this.pvcTentQuantity,
    required this.pvcTentUnit,
    required this.pvcTentPrice,
    required this.normalKicthenQuantity,
    required this.normalKicthenUnit,
    required this.normalKicthenPrice,
    required this.largeKicthenQuantity,
    required this.largeKicthenUnit,
    required this.largeKicthenPrice,
    required this.housingArea,
    required this.companyId,
    required this.company,
    required this.developCompanyId,
    required this.developCompany,
    required this.packageId,
    required this.package,
    required this.packagePrice,
    required this.id,
    required this.ministryAttachmentStateCode,
    required this.deliverySketchStateCode,
    required this.ministryAttachmentFile,
    required this.deliverySketchFile,
    required this.deliveryDate,
    required this.completionReport,
    required this.recieptReport,
    required this.reRecieve,
    required this.zone,
  });

  factory GetAllAssetsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetAllAssetsResponseDataFromJson(json);
}
