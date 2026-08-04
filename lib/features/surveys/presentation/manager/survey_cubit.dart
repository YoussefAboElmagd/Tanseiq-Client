import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_field.dart';
import 'package:tanseiq/features/surveys/data/models/add_survey_post_request.dart';
import 'package:tanseiq/features/surveys/data/models/get_all_surveys_response.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';
import 'package:tanseiq/features/surveys/data/repos/survey_repo.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit(this.surveyRepo) : super(SurveyInitial());
  final SurveyRepo surveyRepo;

  static SurveyCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maxEntriesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? endDate;
  String? startDate;

  // Method to validate dates
  String? validateDates({required BuildContext context}) {
    if (startDate != null && endDate == null) {
      return 'تاكد من تحديد تاريخ الانتهاء';
    }
    if (endDate != null && startDate == null) {
      return 'تاكد من تحديد تاريخ البدء';
    }
    if (startDate != null && endDate != null) {
      final start = DateTime.parse(startDate!);
      final end = DateTime.parse(endDate!);
      if (end.isBefore(start)) {
        return 'تاريخ الانتهاء يجب ان يكون بعد تاريخ البدء';
      }
    }
    return null;
  }

  Future emitCreateSurvey({required BuildContext context}) async {
    final dateValidationError = validateDates(context: context);
    if (dateValidationError != null) {
      emit(SurveyError(dateValidationError, false));
      return;
    }

    emit(SurveyLoading());
    final response = await surveyRepo.createSurvey(
      body: AddSurveyPostRequest(
        name: nameController.text,
        description:
            descriptionController.text == ''
                ? null
                : descriptionController.text,
        startDate: startDate,
        endDate: endDate,
        maxEntries:
            maxEntriesController.text == ''
                ? null
                : int.parse(maxEntriesController.text),
      ),
    );

    await response.when(
      success: (data) {
        clear();
        emit(SurveySuccess());
      },
      failure: (error) {
        emit(SurveyError(error.failure.message ?? '', true));
      },
    );
  }

  Future emitCreateFieldSurvey({
    required BuildContext context,
    required int type,
    required bool isRequired,
    required bool isUnique,
    required String id,
  }) async {
    final dateValidationError = validateDates(context: context);
    if (dateValidationError != null) {
      emit(SurveyError(dateValidationError, false));
      return;
    }

    emit(SurveyLoading());
    final response = await surveyRepo.createFieldSurvey(
      id: id,
      body: AddSurveyFieldsPostRequest(
        fields: [
          AddSurveyField(
            isRequired: isRequired,
            isUnique: isUnique,
            name: nameController.text,
            description:
                descriptionController.text == ''
                    ? null
                    : descriptionController.text,
            type: type,
            placeholder:
                descriptionController.text == ''
                    ? null
                    : descriptionController.text,
          ),
        ],
      ),
    );

    await response.when(
      success: (data) {
        clear();
        emit(SurveySuccess());
      },
      failure: (error) {
        emit(SurveyError(error.failure.message ?? '', true));
      },
    );
  }

  List<GetAllSurveysResponse> allSurveys = [];
  void emitGetAllSurveys() async {
    allSurveys.clear();
    emit(GetAllSurveysLoading());
    final response = await surveyRepo.getAllSurvey();
    response.when(
      success: (data) {
        allSurveys.addAll(data);
        emit(GetAllSurveysSuccess());
      },
      failure: (error) {
        emit(GetAllSurveysError(error.failure.message ?? ''));
      },
    );
  }

  late GetSurveyByIdResponse surveyData;
  void emitGetSurveyById({required String id}) async {
    emit(GetSurveyByIdLoading());
    final response = await surveyRepo.getSurveyById(id: id);
    response.when(
      success: (data) {
        surveyData = data;
        emit(GetSurveyByIdSuccess());
      },
      failure: (error) {
        emit(GetSurveyByIdError(error.failure.message ?? ''));
      },
    );
  }

  Future<bool> askManageExternalStoragePermission({BuildContext? context}) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.photos.request();
        if (status.isGranted || status.isLimited) return true;
      } else {
        status = await Permission.storage.request();
        if (status.isGranted) return true;
      }
    } else if (Platform.isIOS) {
      status = await Permission.photos.request();
      if (status.isGranted || status.isLimited) return true;
    } else {
      return false;
    }

    // Permission denied — if permanently denied, prompt user to open settings
    if (context != null && context.mounted) {
      final isPermanentlyDenied = Platform.isAndroid
          ? await Permission.storage.isPermanentlyDenied ||
              await Permission.photos.isPermanentlyDenied
          : await Permission.photos.isPermanentlyDenied;

      if (isPermanentlyDenied) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('صلاحية الوصول مطلوبة'),
            content: const Text(
              'يجب تفعيل صلاحية الوصول للصور من إعدادات التطبيق للمتابعة.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  openAppSettings();
                },
                child: const Text('فتح الإعدادات'),
              ),
            ],
          ),
        );
      }
    }
    return false;
  }

  File? attachment;
  String extention = '';
  List<String> supportExt = ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx'];
  Future emitPickAttachment({required BuildContext context}) async {
    if (await askManageExternalStoragePermission(context: context)) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any,
        );
        if (result != null) {
          attachment = File(result.files.single.path!);
          extention = attachment!.path.split('.').last;
          emit(UserPickedFile());
        } else {
          emit(UserCanceled());
        }
      } catch (e) {
        debugPrint('Error picking file: $e');
        emit(NoNewFilesAdded());
      }
    }
  }

  void clear() {
    nameController.clear();
    descriptionController.clear();
    maxEntriesController.clear();
    startDate = null;
    endDate = null;
    Constant.startDate = null;
    Constant.endDate = null;
    emit(SurveyClear());
  }
}
