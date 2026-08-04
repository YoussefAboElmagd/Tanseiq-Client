import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart' as persmission;
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_electric_hypothesis_request.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_water_hypothesis_request.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/electric_zone_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_camp_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_sub_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_note_type_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_square_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/water_zone_model.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/repos/electricity_hypotheses_repo.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';
import 'package:location/location.dart';

class ElectricityHypothesesCubit extends Cubit<ElectricityHypothesesStates> {
  ElectricityHypothesesCubit(this.hypothesisRepo)
    : super(ElectricityHypothesesInitial()) {
    for (final key in kDeviceKeys) {
      runningCtrl[key] = TextEditingController();
      totalCtrl[key] = TextEditingController();
      detailsCtrl[key] = TextEditingController();
      kadanaCtrl[key] = TextEditingController();
      deviceImages[key] = [];
    }
  }

  static ElectricityHypothesesCubit get(context) => BlocProvider.of(context);

  static const kDeviceKeys = [
    'waterPumps',
    'lamps',
    'lighting',
    'airConditioners',
    'electricOvens',
    'fans',
    'freezers',
    'plugs',
  ];

  final ElectricityHypothesesRepo hypothesisRepo;

  GlobalKey<FormState> waterFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> electricFormKey = GlobalKey<FormState>();

  TextEditingController anotherDetailsController = TextEditingController();
  TextEditingController nearestRestroomController = TextEditingController();
  TextEditingController kadanasReportController = TextEditingController();
  TextEditingController kedanaProblemController = TextEditingController();

  // Map-based electric device controllers
  final Map<String, TextEditingController> runningCtrl = {};
  final Map<String, TextEditingController> totalCtrl = {};
  final Map<String, TextEditingController> detailsCtrl = {};
  final Map<String, TextEditingController> kadanaCtrl = {};
  final Map<String, List<String>> deviceImages = {};

  // ─── Water Hypothesis ────────────────────────────────────────────────────

  List<WaterZoneModel> zonesList = [];
  List<WaterSquareModel> squaresList = [];
  List<WaterCampModel> campsList = [];
  List<WaterNoteTypeModel> noteTypesList = [];

  String? selectedZone;
  String? selectedZoneId;
  String? selectedSquare;
  String? selectedSquareId;
  String? selectedCampId;
  String? selectedCamp;
  String? selectedNoteType;
  int? selectedNoteId;
  int? selectedSubNoteId;

  emitWaterHypthesis() async {
    await emitGetAllZones();
    await emitGetAllSquares();
    await emitGetUserLocation();
    await emitGetAllNoteTypes();
  }

  Future emitGetAllZones() async {
    zonesList.clear();
    emit(GetAllZonesLoadingState());
    final response = await hypothesisRepo.getAllZones();
    response.when(
      success: (success) {
        zonesList.addAll(success);
        emit(GetAllZonesSuccessState());
      },
      failure: (error) {
        emit(GetAllZonesErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllSquares() async {
    squaresList.clear();
    emit(GetAllSquaresLoadingState());
    final response = await hypothesisRepo.getAllSquares();
    response.when(
      success: (success) {
        squaresList.addAll(success);
        emit(GetAllSquaresSuccessState());
      },
      failure: (error) {
        emit(GetAllSquaresErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllCampsByCompanyId(String zoneId, String squareId) async {
    campsList.clear();
    emit(GetAllCampsLoadingState());
    final response = await hypothesisRepo.getAllCampsByCompanyId(
      zoneId,
      squareId,
    );
    response.when(
      success: (success) {
        campsList.addAll(success);
        emit(GetAllCampsSuccessState());
      },
      failure: (error) {
        emit(GetAllCampsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetallCamps() async {
    campsList.clear();
    emit(GetAllCampsLoadingState());
    final response = await hypothesisRepo.getAllCamps();
    response.when(
      success: (success) {
        campsList.addAll(success);
        emit(GetAllCampsSuccessState());
      },
      failure: (error) {
        emit(GetAllCampsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllNoteTypes() async {
    noteTypesList.clear();
    emit(GetAllNoteTypesLoadingState());
    final response = await hypothesisRepo.getAllNoteTypes();
    response.when(
      success: (success) {
        noteTypesList.addAll(success);
        emit(GetAllNoteTypesSuccessState());
      },
      failure: (error) {
        emit(GetAllNoteTypesErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<WaterNoteSubTypeModel> noteSubTypesList = [];
  int? selectedNoteTypeId;

  Future emitGetNoteSubTypesByNoteTypeId(int noteTypeId) async {
    noteSubTypesList.clear();
    emit(GetNoteSubTypesLoadingState());
    final response = await hypothesisRepo.getNoteSubTypesByNoteTypeId(
      noteTypeId,
    );
    response.when(
      success: (success) {
        noteSubTypesList.addAll(success);
        emit(GetNoteSubTypesSuccessState());
      },
      failure: (error) {
        emit(GetNoteSubTypesErrorState(error.failure.message ?? ''));
      },
    );
  }

  LocationData? currentPosition;

  Future emitGetUserLocation() async {
    emit(GetUserLocationLoadingState());
    try {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(GetUserLocationErrorState('Location services are disabled.'));
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          emit(GetUserLocationErrorState('Location permissions are denied'));
          return;
        }
      }

      currentPosition = await location.getLocation();
      emit(GetUserLocationSuccessState());
    } catch (e) {
      debugPrint('Error getting location: $e');
      emit(GetUserLocationErrorState(e.toString()));
    }
  }

  List<File?> image1 = [];
  List<File?> image2 = [];

  Future emitPickImage({
    required BuildContext context,
    required int imageNumber,
    required int index,
  }) async {
    try {
      final hasPermission = await askManageExternalStoragePermission(
        context: context,
      );
      if (!hasPermission) {
        emit(NoNewFilesAdded());
        return;
      }

      final source = await _showImageSourceDialog(context);
      if (source == null) {
        emit(UserCanceled());
        return;
      }

      if (source == ImageSource.camera) {
        final cameraStatus = await persmission.Permission.camera.request();
        if (!cameraStatus.isGranted) {
          if (context.mounted) {
            await showDialog(
              context: context,
              builder:
                  (ctx) => AlertDialog(
                    title: const Text('صلاحية الكاميرا مطلوبة'),
                    content: const Text('يجب تفعيل صلاحية الكاميرا للمتابعة.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          persmission.openAppSettings();
                        },
                        child: const Text('فتح الإعدادات'),
                      ),
                    ],
                  ),
            );
          }
          emit(NoNewFilesAdded());
          return;
        }
      }

      final XFile? result = await ImagePicker().pickImage(source: source);

      if (result != null) {
        final file = File(result.path);

        if (imageNumber == 1) {
          while (image1.length <= index) {
            image1.add(null);
          }
          image1[index] = file;
        } else if (imageNumber == 2) {
          while (image2.length <= index) {
            image2.add(null);
          }
          image2[index] = file;
        }

        emit(UserPickedFile());
      } else {
        emit(UserCanceled());
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      if (context.mounted) {
        await showDialog(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: const Text('خطأ في اختيار الصورة'),
                content: Text('$e'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('حسناً'),
                  ),
                ],
              ),
        );
      }
      emit(NoNewFilesAdded());
    }
  }

  Future emitPickElectricImage({
    required BuildContext context,
    required String deviceType,
  }) async {
    final current = deviceImages[deviceType] ?? [];
    if (current.length >= 4) {
      debugPrint('Maximum 4 images reached for $deviceType');
      return;
    }

    try {
      final int remaining = 4 - current.length;

      final source = await _showImageSourceDialog(context);
      if (source == null) {
        emit(UserCanceled());
        return;
      }

      List<XFile> result = [];
      if (source == ImageSource.camera) {
        final cameraStatus = await persmission.Permission.camera.request();
        if (!cameraStatus.isGranted) {
          emit(NoNewFilesAdded());
          return;
        }
        final photo = await ImagePicker().pickImage(source: ImageSource.camera);
        if (photo != null) result = [photo];
      } else {
        result = await ImagePicker().pickMultiImage();
      }

      if (result.isNotEmpty) {
        final paths =
            result.map((xfile) => xfile.path).take(remaining).toList();
        deviceImages[deviceType]?.addAll(paths);
        emit(UserPickedFile());
      } else {
        emit(UserCanceled());
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      emit(NoNewFilesAdded());
    }
  }

  void removeElectricImage(String deviceType, int index) {
    final images = deviceImages[deviceType];
    if (images != null && index < images.length) {
      images.removeAt(index);
    }
    emit(UserPickedFile());
  }

  void clearElectricImages(String deviceType) {
    deviceImages[deviceType]?.clear();
    emit(UserPickedFile());
  }

  void clearAllElectricImages() {
    for (final key in kDeviceKeys) {
      deviceImages[key]?.clear();
    }
    emit(UserPickedFile());
  }

  void clearImagesAtIndex(int index) {
    if (image1.length > index) image1[index] = null;
    if (image2.length > index) image2[index] = null;
  }

  void resetAllImages() {
    image1.clear();
    image2.clear();
  }

  Future<bool> askManageExternalStoragePermission({
    BuildContext? context,
  }) async {
    persmission.PermissionStatus status;

    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await persmission.Permission.photos.request();
        if (status.isGranted || status.isLimited) return true;
      } else {
        status = await persmission.Permission.storage.request();
        if (status.isGranted) return true;
      }
    } else if (Platform.isIOS) {
      status = await persmission.Permission.photos.request();
      if (status.isGranted || status.isLimited) return true;
    } else {
      return false;
    }

    if (context != null && context.mounted) {
      final isPermanentlyDenied =
          Platform.isAndroid
              ? await persmission.Permission.storage.isPermanentlyDenied ||
                  await persmission.Permission.photos.isPermanentlyDenied
              : await persmission.Permission.photos.isPermanentlyDenied;

      if (isPermanentlyDenied) {
        await showDialog(
          context: context,
          builder:
              (ctx) => AlertDialog(
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
                      persmission.openAppSettings();
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

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder:
          (ctx) => SafeArea(
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

  List<NoteData> notesList = [];

  Future emitAddWaterHypothesis({
    required int campId,
    required String square,
    required String zone,
    required String camp,
    required bool isThereIsANote,
  }) async {
    emit(AddWaterHypothesisLoadingState());
    try {
      AddWaterHypothesisRequest request;
      if (isThereIsANote) {
        request = AddWaterHypothesisRequest(
          campId: campId,
          camp: camp,
          square: square,
          zone: zone,
          isThereIsANote: isThereIsANote,
          notes:
              notesList.map((noteData) {
                return NoteRequest(
                  hypothesisId: null,
                  noteType: noteData.noteType,
                  noteSubType: noteData.noteSubType,
                  anotherDetails: noteData.anotherDetails,
                  kadanasReportNumber: noteData.kadanasReportNumber,
                  nearestRestroomNumber: noteData.nearestRestroomNumber,
                  caseImages:
                      noteData.caseImage != null
                          ? [noteData.caseImage!.path]
                          : null,
                  placeImages:
                      noteData.placeImage != null
                          ? [noteData.placeImage!.path]
                          : null,
                );
              }).toList(),
        );
      } else {
        request = AddWaterHypothesisRequest(
          hypothesisId: null,
          campId: campId,
          camp: camp,
          square: square,
          zone: zone,
          isThereIsANote: isThereIsANote,
        );
      }

      final response = await hypothesisRepo.addWaterHypothesis(
        request,
        latitude: currentPosition?.latitude,
        longitude: currentPosition?.longitude,
      );

      response.when(
        success: (success) {
          if (success.isError == true) {
            emit(AddWaterHypothesisErrorState(success.message ?? ''));
          } else {
            notesList.clear();
            emit(
              AddWaterHypothesisSuccessState(
                success.message ?? 'تم إضافة الفرضية بنجاح',
              ),
            );
          }
        },
        failure: (error) {
          emit(AddWaterHypothesisErrorState(error.failure.message ?? ''));
        },
      );
    } catch (e) {
      debugPrint('Error adding hypothesis: $e');
      emit(AddWaterHypothesisErrorState(e.toString()));
    }
  }

  void addOrUpdateNoteAtIndex({
    required int index,
    int? noteType,
    int? noteSubType,
    String? anotherDetails,
    String? kadanasReportNumber,
    String? nearestRestroomNumber,
    File? caseImage,
    File? placeImage,
  }) {
    while (notesList.length <= index) {
      notesList.add(NoteData(noteType: null, noteSubType: null));
    }

    final existingNote = notesList[index];
    notesList[index] = NoteData(
      noteType: noteType ?? existingNote.noteType,
      noteSubType: noteSubType ?? existingNote.noteSubType,
      anotherDetails: anotherDetails ?? existingNote.anotherDetails,
      kadanasReportNumber:
          kadanasReportNumber ?? existingNote.kadanasReportNumber,
      nearestRestroomNumber:
          nearestRestroomNumber ?? existingNote.nearestRestroomNumber,
      caseImage: caseImage ?? existingNote.caseImage,
      placeImage: placeImage ?? existingNote.placeImage,
    );
  }

  // ─── Electric Hypothesis ─────────────────────────────────────────────────

  List<ElectricZoneModel> electricZonesList = [];
  List<WaterSquareModel> electricSquaresList = [];
  List<WaterCampModel> electricCampsList = [];
  String? selectedElectricZone;
  String? selectedElectricSquare;
  String? selectedElectricCampId;
  String? selectedElectricCampName;

  Future emitGetElectricZones() async {
    electricZonesList.clear();
    emit(GetElectricZonesLoadingState());
    final response = await hypothesisRepo.getElectricZones();
    response.when(
      success: (success) {
        electricZonesList.addAll(success);
        emit(GetElectricZonesSuccessState());
      },
      failure: (error) {
        emit(GetElectricZonesErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetElectricSquares() async {
    electricSquaresList.clear();
    emit(GetElectricSquaresLoadingState());
    final response = await hypothesisRepo.getElectricSquares();
    response.when(
      success: (success) {
        electricSquaresList.addAll(success);
        emit(GetElectricSquaresSuccessState());
      },
      failure: (error) {
        emit(GetElectricSquaresErrorState(error.failure.message ?? ''));
      },
    );
  }

  emitElectricHypothesis() async {
    await emitGetElectricZones();
    if (electricZonesList.isNotEmpty) {
      selectedElectricZone = electricZonesList.first.id?.toString();
    }
    await emitGetElectricSquares();
    if (selectedElectricZone != null) {
      await emitGetElectricCampsByCompanyId(null);
    }
  }

  Future emitGetElectricCampsByCompanyId(String? squareId) async {
    if (selectedElectricZone == null) return;
    electricCampsList.clear();
    emit(GetElectricCampsLoadingState());
    final companyId = CachHelper.getData(key: 'companyId')?.toString();
    final response = await hypothesisRepo.getElectricCampsByCompanyId(
      selectedElectricZone!,
      squareId: squareId,
      companyId: companyId,
    );
    response.when(
      success: (success) {
        electricCampsList.addAll(success);
        emit(GetElectricCampsSuccessState());
      },
      failure: (error) {
        emit(GetElectricCampsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitAddElectricHypothesis(AddElectricHypothesisRequest request) async {
    emit(AddElectricHypothesisLoadingState());
    final response = await hypothesisRepo.addElectricHypothesis(
      request: request,
      deviceImages: deviceImages,
    );
    response.when(
      success: (success) {
        if (success.isError == true) {
          emit(AddElectricHypothesisErrorState(success.message ?? ''));
        } else {
          emit(
            AddElectricHypothesisSuccessState(
              success.message ?? 'تم إضافة الفرضية الكهربائية بنجاح',
            ),
          );
        }
      },
      failure: (error) {
        emit(AddElectricHypothesisErrorState(error.failure.message ?? ''));
      },
    );
  }

  @override
  Future<void> close() {
    anotherDetailsController.dispose();
    nearestRestroomController.dispose();
    kadanasReportController.dispose();
    kedanaProblemController.dispose();
    for (final key in kDeviceKeys) {
      runningCtrl[key]?.dispose();
      totalCtrl[key]?.dispose();
      detailsCtrl[key]?.dispose();
      kadanaCtrl[key]?.dispose();
    }
    return super.close();
  }
}

class NoteData {
  int? noteType;
  int? noteSubType;
  String? noteTypeName;
  String? anotherDetails;
  String? kadanasReportNumber;
  String? nearestRestroomNumber;
  File? caseImage;
  File? placeImage;

  NoteData({
    this.noteType,
    this.noteSubType,
    this.noteTypeName,
    this.anotherDetails,
    this.kadanasReportNumber,
    this.nearestRestroomNumber,
    this.caseImage,
    this.placeImage,
  });
}
