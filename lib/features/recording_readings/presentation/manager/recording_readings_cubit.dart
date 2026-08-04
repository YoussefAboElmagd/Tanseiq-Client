import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_all_generators_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_developer_company_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_map_points.dart';
import 'package:tanseiq/features/recording_readings/data/repo/recording_readings_repo.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_states.dart';

class RecordingReadingsCubit extends Cubit<RecordingReadingsStates> {
  RecordingReadingsCubit(this.recordingReadingsRepo)
    : super(RecordingReadingsInitial());
  RecordingReadingsRepo recordingReadingsRepo;
  static RecordingReadingsCubit get(context) => BlocProvider.of(context);

  TextEditingController rController = TextEditingController();
  TextEditingController yController = TextEditingController();
  TextEditingController bController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future emitSaveReading(BuildContext context, int id) async {
    emit(SaveReadingLoadingState());
    final response = await recordingReadingsRepo.saveReading(
      generatorId: id,
      r: double.parse(rController.text),
      y: double.parse(yController.text),
      b: double.parse(bController.text),
      image: image,
    );
    await response.when(
      success: (success) async {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: 'تم حفظ القراءة بنجاح',
            color: ColorsManager.green,
          ),
        );
        clearAll();
        await emitGetReadingsView();
        emit(SaveReadingSuccessState());
      },
      failure: (error) {
        debugPrint(error.failure.message);
        emit(SaveReadingErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('الكاميرا'),
              onTap: () => Navigator.of(ctx).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('المعرض'),
              onTap: () => Navigator.of(ctx).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  File? image;
  Future emitPickImage({required BuildContext context}) async {
    try {
      final source = await _showImageSourceDialog(context);
      if (source == null) {
        emit(UserCanceled());
        return;
      }
      final XFile? result = await ImagePicker().pickImage(
        source: source,
      );
      if (result != null) {
        image = File(result.path);
        emit(UserPickedFile());
      } else {
        emit(UserCanceled());
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      emit(NoNewFilesAdded());
    }
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

  List<GetZoneResponse> zones = [];
  String zoneId = '';
  Future emitGetDropDownZoneFilter() async {
    zones.clear();
    emit(GetZonesLoadingState());
    final response = await recordingReadingsRepo.getDropDownZoneFilter();
    response.when(
      success: (data) {
        zones.addAll(data);
        emit(GetZonesSuccessState());
      },
      failure: (error) {
        emit(GetZonesErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetDropDownFilterResponse> filterList = [];
  String filterId = '';
  Future emitGetDropDownFilter() async {
    filterList.clear();
    emit(GetDropDownFilterLoadingState());
    final response = await recordingReadingsRepo.getDropDownFilter();
    response.when(
      success: (success) {
        filterList.addAll(success);
        emit(GetDropDownFilterSuccessState());
      },
      failure: (error) {
        emit(GetDropDownFilterErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetDeveloperCompanyResponse> developerList = [];
  String developerId = '';
  Future emitGetDropDownDeveloper() async {
    developerList.clear();
    emit(GetDeveloperCompanyLoadingState());
    final response = await recordingReadingsRepo.getDropDownDeveloper();
    response.when(
      success: (success) {
        developerList.addAll(success);
        emit(GetDeveloperCompanySuccessState());
      },
      failure: (error) {
        emit(GetDeveloperCompanyErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetGeneratorsSerialsResponse> generatorsList = [];
  String generatorId = '';
  Future emitGetGeneratorsSerials() async {
    generatorsList.clear();
    emit(GetGeneratorsSerialsLoadingState());
    final response = await recordingReadingsRepo.getGeneratorsSerials();
    response.when(
      success: (success) {
        generatorsList.addAll(success);
        emit(GetGeneratorsSerialsSuccessState());
      },
      failure: (error) {
        emit(GetGeneratorsSerialsErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetMapPoints> mapPoints = [];
  Future emitGetMapPoints() async {
    mapPoints.clear();
    emit(GetMapPointsLoadingState());
    final response = await recordingReadingsRepo.getMapPoints(
      developerCompanyId: int.parse(developerId.isEmpty ? '0' : developerId),
      generatorId: int.parse(generatorId.isEmpty ? '0' : generatorId),
      zoneId: int.parse(zoneId.isEmpty ? '0' : zoneId),
      serviceCompanyId: int.parse(filterId.isEmpty ? '0' : filterId),
    );
    response.when(
      success: (success) {
        mapPoints.addAll(success);
        emit(GetMapPointsSuccessState());
      },
      failure: (error) {
        emit(GetMapPointsErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GeneratorsData> generatorsData = [];
  int page = 0;
  bool hasNext = true;
  Future emitGetAllReadings() async {
    hasNext = true;
    generatorsData.clear();
    emit(GetAllGeneratorsLoadingState());
    final response = await recordingReadingsRepo.getReadings(
      page: page,
      pageSize: 10,
      developerCompanyId: int.parse(developerId.isEmpty ? '0' : developerId),
      generatorId: int.parse(generatorId.isEmpty ? '0' : generatorId),
      zoneId: int.parse(zoneId.isEmpty ? '0' : zoneId),
      serviceCompanyId: int.parse(filterId.isEmpty ? '0' : filterId),
    );
    response.when(
      success: (data) {
        generatorsData.addAll(data.data);
        emit(GetAllGeneratorsSuccessState());
      },
      failure: (error) {
        emit(GetAllGeneratorsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllReadingsPagination() async {
    emit(GetAllGeneratorsPaginationLoadingState());
    final response = await recordingReadingsRepo.getReadings(
      page: page,
      pageSize: 10,
      developerCompanyId: int.parse(developerId.isEmpty ? '0' : developerId),
      generatorId: int.parse(generatorId.isEmpty ? '0' : generatorId),
      zoneId: int.parse(zoneId.isEmpty ? '0' : zoneId),
      serviceCompanyId: int.parse(filterId.isEmpty ? '0' : filterId),
    );
    int length = generatorsData.length;

    response.when(
      success: (data) {
        page = data.currentPage;
        generatorsData.addAll(data.data);
        if (generatorsData.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }

        emit(GetAllGeneratorsPaginationSuccessState());
      },
      failure: (error) {
        emit(GetAllGeneratorsPaginationErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetGeneratorsReadingByTime> readingsList = [];
  Future emitGetReadingsView() async {
    readingsList.clear();
    emit(GetGeneratorsReadingLoadingState());
    final response = await recordingReadingsRepo.getReadingsView(
      developerCompanyId: developerId.isEmpty ? 0 : int.parse(developerId),
      rentalCompanyId: filterId.isEmpty ? 0 : int.parse(filterId),
    );
    response.when(
      success: (data) {
        readingsList.addAll(data);
        emit(GetGeneratorsReadingSuccessState());
      },
      failure: (error) {
        emit(GetGeneratorsReadingErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetGeneratorsMethods() async {
    // await emitGetGeneratorsSerials();
    await emitGetDropDownDeveloper();
    await emitGetDropDownFilter();
    // await emitGetDropDownZoneFilter();
    // await emitGetAllReadings();
    await emitGetReadingsView();
  }

  void clearAll() {
    generatorId = '';
    zoneId = '';
    developerId = '';
    filterId = '';
    page = 0;
    rController.clear();
    yController.clear();
    bController.clear();
    emit(ClearAllDataState());
  }
}
