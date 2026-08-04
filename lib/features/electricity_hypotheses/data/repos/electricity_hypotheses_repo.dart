// Changelog:
// 2026-03-27 - Youssef Helmy
// - Updated getAllCampsByCompanyId to send JSON body instead of FormData
// - Updated getElectricCampsByCompanyId to send JSON body instead of FormData
// 2026-05-14
// - Updated getElectricCampsByCompanyId to accept optional squareId and companyId
// - Updated addElectricHypothesis to use new model with IsPowerOutage, fans, freezers, plugs

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/apis/electricity_hypotheses_api_services.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_electric_hypothesis_request.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_electric_hypothesis_response.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_water_hypothesis_request.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_water_hypothesis_response.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/electric_zone_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_camp_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_sub_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_square_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_zone_model.dart';

class ElectricityHypothesesRepo {
  final ElectricityHypothesesApiServices hypothesisApiServices;

  ElectricityHypothesesRepo(this.hypothesisApiServices);

  Future<ApiResult<List<WaterZoneModel>>> getAllZones() async {
    try {
      final response = await hypothesisApiServices.getAllZones();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterSquareModel>>> getAllSquares() async {
    try {
      final response = await hypothesisApiServices.getAllSquares();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterCampModel>>> getAllCampsByCompanyId(
    String zoneId,
    String squareId,
  ) async {
    try {
      final response = await hypothesisApiServices.getAllCampsByCompanyId({
        'ZoneId': zoneId,
        'SquareId': squareId,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterCampModel>>> getAllCamps() async {
    try {
      final response = await hypothesisApiServices.getAllCamps();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterNoteTypeModel>>> getAllNoteTypes() async {
    try {
      final response = await hypothesisApiServices.getAllNoteTypes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterNoteSubTypeModel>>> getNoteSubTypesByNoteTypeId(
    int noteTypeId,
  ) async {
    try {
      final response = await hypothesisApiServices.getNoteSubTypesByNoteTypeId(
        noteTypeId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AddWaterHypothesisResponse>> addWaterHypothesis(
    AddWaterHypothesisRequest request, {
    double? latitude,
    double? longitude,
  }) async {
    try {
      FormData formData = FormData();

      formData.fields.add(MapEntry('CampId', request.campId?.toString() ?? ''));
      formData.fields.add(MapEntry('Latitude', (latitude ?? 0).toString()));
      formData.fields.add(MapEntry('Longitude', (longitude ?? 0).toString()));
      formData.fields.add(
        MapEntry(
          'IsThereIsANote',
          request.isThereIsANote?.toString() ?? 'false',
        ),
      );

      if (request.notes != null && request.notes!.isNotEmpty) {
        for (int i = 0; i < request.notes!.length; i++) {
          final note = request.notes![i];

          if (note.hypothesisId != null) {
            formData.fields.add(
              MapEntry(
                'Notes[$i].hypothesisId',
                note.hypothesisId!.toString(),
              ),
            );
          }
          if (note.noteType != null) {
            formData.fields.add(
              MapEntry('Notes[$i].NoteType', note.noteType!.toString()),
            );
          }
          if (note.anotherDetails != null && note.anotherDetails!.isNotEmpty) {
            formData.fields.add(
              MapEntry('Notes[$i].anotherDetails', note.anotherDetails!),
            );
          }
          if (note.noteSubType != null) {
            formData.fields.add(
              MapEntry('Notes[$i].NoteSubType', note.noteSubType!.toString()),
            );
          }
          if (note.nearestRestroomNumber != null &&
              note.nearestRestroomNumber!.isNotEmpty) {
            formData.fields.add(
              MapEntry(
                'Notes[$i].nearestRestroomNumber',
                note.nearestRestroomNumber!,
              ),
            );
          }
          if (note.kadanasReportNumber != null &&
              note.kadanasReportNumber!.isNotEmpty) {
            formData.fields.add(
              MapEntry(
                'Notes[$i].kadanasReportNumber',
                note.kadanasReportNumber!,
              ),
            );
          }
          if (note.caseImages != null && note.caseImages!.isNotEmpty) {
            for (String imagePath in note.caseImages!) {
              if (imagePath.isNotEmpty) {
                final file = File(imagePath);
                if (await file.exists()) {
                  final bytes = await file.readAsBytes();
                  formData.files.add(
                    MapEntry(
                      'Notes[$i].CaseImagesFiles',
                      MultipartFile.fromBytes(
                        bytes,
                        filename: file.path.split('/').last,
                      ),
                    ),
                  );
                }
              }
            }
          }
          if (note.placeImages != null && note.placeImages!.isNotEmpty) {
            for (String imagePath in note.placeImages!) {
              if (imagePath.isNotEmpty) {
                final file = File(imagePath);
                if (await file.exists()) {
                  final bytes = await file.readAsBytes();
                  formData.files.add(
                    MapEntry(
                      'Notes[$i].PlaceImagesFiles',
                      MultipartFile.fromBytes(
                        bytes,
                        filename: file.path.split('/').last,
                      ),
                    ),
                  );
                }
              }
            }
          }
        }
      }

      final response = await hypothesisApiServices.addWaterHypothesis(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<ElectricZoneModel>>> getElectricZones() async {
    try {
      final response = await hypothesisApiServices.getElectricZones();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterSquareModel>>> getElectricSquares() async {
    try {
      final response = await hypothesisApiServices.getElectricSquares();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<WaterCampModel>>> getElectricCampsByCompanyId(
    String zoneId, {
    String? squareId,
    String? companyId,
  }) async {
    try {
      final body = <String, dynamic>{'ZoneId': zoneId};
      if (squareId != null) body['SquareId'] = squareId;
      if (companyId != null) body['CompanyId'] = companyId;
      final response = await hypothesisApiServices.getElectricCampsByCompanyId(
        body,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<void> _addFilesToFormData(
    FormData formData,
    String fieldName,
    List<File>? files,
  ) async {
    if (files == null || files.isEmpty) return;
    for (final file in files) {
      final bytes = await file.readAsBytes();
      formData.files.add(
        MapEntry(
          fieldName,
          MultipartFile.fromBytes(bytes, filename: file.path.split('/').last),
        ),
      );
    }
  }

  List<File>? _toFiles(List<String>? paths) {
    if (paths == null || paths.isEmpty) return null;
    return paths.map((p) => File(p)).toList();
  }

  Future<ApiResult<AddElectricHypothesisResponse>> addElectricHypothesis({
    required AddElectricHypothesisRequest request,
    required Map<String, List<String>> deviceImages,
  }) async {
    try {
      final formData = FormData();

      if (request.squareId != null) {
        formData.fields.add(
          MapEntry('SquareId', request.squareId!.toString()),
        );
      }
      if (request.campId != null) {
        formData.fields.add(MapEntry('CampId', request.campId!.toString()));
      }
      if (request.isPowerOutage != null) {
        formData.fields.add(
          MapEntry('IsPowerOutage', request.isPowerOutage!.toString()),
        );
      }
      if (request.kedanaProblemNumber != null &&
          request.kedanaProblemNumber!.isNotEmpty) {
        formData.fields.add(
          MapEntry('KedanaProblemNumber', request.kedanaProblemNumber!),
        );
      }

      // waterPumps → WaterBoilers fields
      if (request.isAllWaterBoilersOn != null) {
        formData.fields.add(
          MapEntry(
            'IsAllWaterBoilersOn',
            request.isAllWaterBoilersOn!.toString(),
          ),
        );
      }
      if (request.runningBoilerCount != null) {
        formData.fields.add(
          MapEntry('RunningBoilerCount', request.runningBoilerCount!.toString()),
        );
      }
      if (request.totalBoilerCount != null) {
        formData.fields.add(
          MapEntry('TotalBoilerCount', request.totalBoilerCount!.toString()),
        );
      }
      if (request.boilerDetails != null) {
        formData.fields.add(MapEntry('BoilerDetails', request.boilerDetails!));
      }
      if (request.boilerkadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'BoilerkadanasReportNumber',
            request.boilerkadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'BoilerImagesFile',
        _toFiles(deviceImages['waterPumps']),
      );

      // lamps → Refrigerators fields
      if (request.isAllRefrigeratorsOn != null) {
        formData.fields.add(
          MapEntry(
            'IsAllRefrigeratorsOn',
            request.isAllRefrigeratorsOn!.toString(),
          ),
        );
      }
      if (request.runningFridgeCount != null) {
        formData.fields.add(
          MapEntry('RunningFridgeCount', request.runningFridgeCount!.toString()),
        );
      }
      if (request.totalFridgeCount != null) {
        formData.fields.add(
          MapEntry('TotalFridgeCount', request.totalFridgeCount!.toString()),
        );
      }
      if (request.fridgeDetails != null) {
        formData.fields.add(MapEntry('FridgeDetails', request.fridgeDetails!));
      }
      if (request.fridgekadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'FridgekadanasReportNumber',
            request.fridgekadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'FridgeImagesFile',
        _toFiles(deviceImages['lamps']),
      );

      // lighting
      if (request.isAllLightingOn != null) {
        formData.fields.add(
          MapEntry('IsAllLightingOn', request.isAllLightingOn!.toString()),
        );
      }
      if (request.runningLightingCount != null) {
        formData.fields.add(
          MapEntry(
            'RunningLightingCount',
            request.runningLightingCount!.toString(),
          ),
        );
      }
      if (request.totalLightingCount != null) {
        formData.fields.add(
          MapEntry(
            'TotalLightingCount',
            request.totalLightingCount!.toString(),
          ),
        );
      }
      if (request.lightingDetails != null) {
        formData.fields.add(
          MapEntry('LightingDetails', request.lightingDetails!),
        );
      }
      if (request.lightingkadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'LightingkadanasReportNumber',
            request.lightingkadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'LightingImagesFiles',
        _toFiles(deviceImages['lighting']),
      );

      // airConditioners
      if (request.isAllAirConditionersOn != null) {
        formData.fields.add(
          MapEntry(
            'IsAllAirConditionersOn',
            request.isAllAirConditionersOn!.toString(),
          ),
        );
      }
      if (request.runningAirConditionerCount != null) {
        formData.fields.add(
          MapEntry(
            'RunningAirConditionerCount',
            request.runningAirConditionerCount!.toString(),
          ),
        );
      }
      if (request.totalAirConditionerCount != null) {
        formData.fields.add(
          MapEntry(
            'TotalAirConditionerCount',
            request.totalAirConditionerCount!.toString(),
          ),
        );
      }
      if (request.airConditionerDetails != null) {
        formData.fields.add(
          MapEntry('AirConditionerDetails', request.airConditionerDetails!),
        );
      }
      if (request.airConditionerkadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'AirConditionerkadanasReportNumber',
            request.airConditionerkadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'AirConditionerImagesFiles',
        _toFiles(deviceImages['airConditioners']),
      );

      // electricOvens
      if (request.isAllElectricOvensOn != null) {
        formData.fields.add(
          MapEntry(
            'IsAllElectricOvensOn',
            request.isAllElectricOvensOn!.toString(),
          ),
        );
      }
      if (request.runningElectricOvenCount != null) {
        formData.fields.add(
          MapEntry(
            'RunningElectricOvenCount',
            request.runningElectricOvenCount!.toString(),
          ),
        );
      }
      if (request.totalElectricOvenCount != null) {
        formData.fields.add(
          MapEntry(
            'TotalElectricOvenCount',
            request.totalElectricOvenCount!.toString(),
          ),
        );
      }
      if (request.electricOvenDetails != null) {
        formData.fields.add(
          MapEntry('ElectricOvenDetails', request.electricOvenDetails!),
        );
      }
      if (request.electricOvenkadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'ElectricOvenkadanasReportNumber',
            request.electricOvenkadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'ElectricOvenImagesFiles',
        _toFiles(deviceImages['electricOvens']),
      );

      // fans
      if (request.isFansOn != null) {
        formData.fields.add(
          MapEntry('IsFansOn', request.isFansOn!.toString()),
        );
      }
      if (request.runningFansCount != null) {
        formData.fields.add(
          MapEntry('RunningFansCount', request.runningFansCount!.toString()),
        );
      }
      if (request.totalFansCount != null) {
        formData.fields.add(
          MapEntry('TotalFansCount', request.totalFansCount!.toString()),
        );
      }
      if (request.fansDetails != null) {
        formData.fields.add(MapEntry('FansDetails', request.fansDetails!));
      }
      if (request.fansKadanasReportNumber != null) {
        formData.fields.add(
          MapEntry('FansKadanasReportNumber', request.fansKadanasReportNumber!),
        );
      }
      await _addFilesToFormData(
        formData,
        'FansImagesFiles',
        _toFiles(deviceImages['fans']),
      );

      // freezers
      if (request.isFreezersOn != null) {
        formData.fields.add(
          MapEntry('IsFreezersOn', request.isFreezersOn!.toString()),
        );
      }
      if (request.runningFreezersCount != null) {
        formData.fields.add(
          MapEntry(
            'RunningFreezersCount',
            request.runningFreezersCount!.toString(),
          ),
        );
      }
      if (request.totalFreezersCount != null) {
        formData.fields.add(
          MapEntry(
            'TotalFreezersCount',
            request.totalFreezersCount!.toString(),
          ),
        );
      }
      if (request.freezersDetails != null) {
        formData.fields.add(
          MapEntry('FreezersDetails', request.freezersDetails!),
        );
      }
      if (request.freezersKadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'FreezersKadanasReportNumber',
            request.freezersKadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'FreezersImagesFiles',
        _toFiles(deviceImages['freezers']),
      );

      // plugs
      if (request.isPlugsOn != null) {
        formData.fields.add(
          MapEntry('IsPlugsOn', request.isPlugsOn!.toString()),
        );
      }
      if (request.runningPlugsCount != null) {
        formData.fields.add(
          MapEntry('RunningPlugsCount', request.runningPlugsCount!.toString()),
        );
      }
      if (request.totalPlugsCount != null) {
        formData.fields.add(
          MapEntry('TotalPlugsCount', request.totalPlugsCount!.toString()),
        );
      }
      if (request.plugsDetails != null) {
        formData.fields.add(MapEntry('PlugsDetails', request.plugsDetails!));
      }
      if (request.plugsKadanasReportNumber != null) {
        formData.fields.add(
          MapEntry(
            'PlugsKadanasReportNumber',
            request.plugsKadanasReportNumber!,
          ),
        );
      }
      await _addFilesToFormData(
        formData,
        'PlugsImagesFiles',
        _toFiles(deviceImages['plugs']),
      );

      final result = await hypothesisApiServices.addElectricHypothesis(
        formData,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
