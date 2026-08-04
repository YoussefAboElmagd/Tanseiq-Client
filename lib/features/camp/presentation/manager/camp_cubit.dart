import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/location_service.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_body_response.dart';
import 'package:tanseiq/features/camp/data/models/get_all_tent_request_body.dart';
import 'package:tanseiq/features/camp/data/models/get_all_tent_response_body.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_classifications_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_terms_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_building_preparing_works_request.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_building_works_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_details_response.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_preparing_works_response.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/camp/data/repo/camp_repo.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';

class CampCubit extends Cubit<CampStates> {
  CampCubit(this.campRepo, {LocationService? locationService})
    : locationService = locationService ?? LocationService(),
      super(CampInitial());
  final CampRepo campRepo;
  final LocationService locationService;
  bool canEditCamp =
      CachHelper.getData(key: 'userType') == 'استشاري' ? true : false;

  double distance = 0;

  /// Call this after loading campDetails to check if user is near the camp
  Future<void> checkEditPermissionForCamp() async {
    emit(CampEditPermissionLoadingState());
    if (campDetails.lat == null || campDetails.lng == null) {
      canEditCamp = false;
      emit(CampEditPermissionState(false));
      return;
    }
    bool service = await locationService.checkAndRequestLocationService();
    bool perm = await locationService.checkAndRequestLocationPermission();
    if (!service || !perm) {
      canEditCamp = false;
      emit(CampEditPermissionState(false));
      return;
    }
    LocationData? current = await locationService.getCurrentLocation();
    if (current == null ||
        current.latitude == null ||
        current.longitude == null) {
      canEditCamp = false;
      emit(CampEditPermissionState(false));
      return;
    }
    distance = _calculateDistance(
      campDetails.lat!,
      campDetails.lng!,
      current.latitude!,
      current.longitude!,
    );
    // Allow edit if within 100 meters
    canEditCamp = distance <= 50;
    emit(CampEditPermissionState(canEditCamp));
  }

  /// Haversine formula for distance in meters
  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const double R = 6371000; // Earth radius in meters
    double dLat = _deg2rad(lat2 - lat1);
    double dLng = _deg2rad(lng2 - lng1);
    double a =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            (sin(dLng / 2) * sin(dLng / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * (3.141592653589793 / 180.0);
  static CampCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  int currentIndexTabBar = 0;
  int currentCampAnalysis = 0;
  TextEditingController campNumberController = TextEditingController();
  TextEditingController tentArea = TextEditingController();
  TextEditingController housingArea = TextEditingController();
  TextEditingController kitchenNumber = TextEditingController();
  TextEditingController numberOfCollectionToilets = TextEditingController();
  TextEditingController numberOfToilets = TextEditingController();
  TextEditingController numberOfHajjToilet = TextEditingController();
  String squareId = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeStructure(List<GetCampBuildingWorksData> data, int index) {
    data[index].structure = !data[index].structure;
    emit(ChangeStructureState());
  }

  void changeSupply(List<GetCampBuildingWorksData> data, int index) {
    data[index].supply = !data[index].supply;
    emit(ChangeSupplyState());
  }

  void changePrepareTintItem(int index) {
    currentIndex = index;
    emit(ChangePrepareTintItem());
  }

  void emitSelectCampAnalysisScreen(int index) {
    clearAllData();
    currentCampAnalysis = index;
    emit(ChangePrepareTintItem());
  }

  List<GetAllCampsBodyResponse> camps = [];
  Future<void> emitGetAllCamps() async {
    camps.clear();
    emit(GetAllCampLoading());
    final result = await campRepo.getAllCamps();
    result.when(
      success: (data) {
        camps.addAll(data);
        emit(GetAllCampSuccess());
      },
      failure: (error) {
        emit(GetAllCampError(error.failure.message ?? ''));
      },
    );
  }

  Set<Marker> markers = {};
  GoogleMapController? googleController;
  void emitSelectLocation({required LatLng location}) {
    markers.add(Marker(markerId: const MarkerId('1'), position: location));
    googleController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 17),
      ),
    );
    emit(SelectLocationState());
  }

  int page = 0;
  String? companyId;
  String? campNumber;
  String? zone;
  List<String> campNumbers = [];
  bool hasNext = true;

  GetAllTentResponseBody? tentDetails;
  Future emitGetAllTents({
    String? zone,
    String? companyId,
    String? campNumber,
  }) async {
    emit(GetAllTentsLoading());
    final response = await campRepo.postRequestTent(
      GetAllTentRequestBody(
        companyId: int.parse(companyId ?? '0'),
        page: 0,
        developerId: 0,
        pageSize: 30,
        zone: zone,
        campNumber: campNumber,
      ),
    );
    response.when(
      success: (success) {
        tentDetails = success;
        campNumber == null
            ? campNumbers =
                success.tents
                    .map((e) => e.campNumber)
                    .where((item) => item != null)
                    .map((item) => item!)
                    .toSet()
                    .toList()
            : campNumbers.clear();
        emit(GetAllTentsSuccess());
      },
      failure: (error) {
        emit(GetAllTentsError(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllTentsPagination({
    String? zone,
    String? companyId,
    String? campNumber,
  }) async {
    emit(GetAllTentsPaginationLoading());
    final response = await campRepo.postRequestTent(
      GetAllTentRequestBody(
        companyId: int.parse(companyId ?? '0'),
        page: page,
        developerId: 0,
        pageSize: 30,
        zone: zone,
        campNumber: campNumber,
      ),
    );
    int length = tentDetails!.tents.length;
    response.when(
      success: (success) {
        page = success.currentPage;
        tentDetails = success;
        if (tentDetails!.tents.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        campNumber == null
            ? campNumbers =
                success.tents.map((e) => e.campNumber ?? 'غير محدد').toList()
            : campNumbers.clear();
        emit(GetAllTentsPaginationSuccess());
      },
      failure: (error) {
        emit(GetAllTentsPaginationError(error.failure.message ?? ''));
      },
    );
  }

  late GetCampDetailsResponse campDetails;
  Future emitGetCampDetails({required String campId}) async {
    emit(GetCampDetailsLoading());
    final response = await campRepo.getCampDetails(int.parse(campId));
    await response.when(
      success: (success) async {
        campDetails = success;
        emit(GetCampDetailsSuccess());
        CachHelper.getData(key: 'userType') == 'استشاري'
            ? null
            : await checkEditPermissionForCamp();
      },
      failure: (error) {
        emit(GetCampDetailsError(error.failure.message ?? ''));
      },
    );
  }

  GetHomeStatisticsResponse? statistics;
  Future emitGetStatistics() async {
    emit(StatisticsLoadingState());
    final response = await campRepo.getStatistics();
    response.when(
      success: (success) {
        statistics = success;
        emit(StatisticsSuccessState());
      },
      failure: (error) {
        emit(StatisticsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitTintDetailsMethods({String? zone, String? companyId}) async {
    await emitGetStatistics();
    await emitGetDropDownFilter();
    if (statistics != null) {
      await emitGetAllTents();
    }
  }

  Future emitTintDetailsInMinaMethods({String? zone, String? companyId}) async {
    await emitGetDropDownFilter();
    await emitGetAllTents(zone: 'منى');
  }

  Future emitGetPreparingCampServices() async {
    emit(GetPreparingCampServicesLoading());
    final respone = await campRepo.getPreparingCampServices(1);
    respone.when(
      success: (success) {
        emit(GetPreparingCampServicesSuccess());
      },
      failure: (error) {
        emit(GetPreparingCampServicesError(error.failure.message ?? ''));
      },
    );
  }

  GetCampBuildingWorksResponse? buildingWorksResponse;
  Future emitGetCampBuildingWorks() async {
    emit(GetCampBuildingWorkLoading());
    final respone = await campRepo.getCampBuildingWorks(
      GetCampBuildingPreparingWorksRequest(
        page: page,
        pageSize: 10,
        campId: 0,
        tentId: 0,
      ),
    );
    respone.when(
      success: (success) {
        buildingWorksResponse = success;
        emit(GetCampBuildingWorkSuccess());
      },
      failure: (error) {
        emit(GetCampBuildingWorkError(error.failure.message ?? ''));
      },
    );
  }

  List<GetCampPreparingWorksResponse> prepare = [];
  Future emitGetCampPreparingWorks({required String campId}) async {
    prepare.clear();
    emit(GetCampPreparingWorkLoading());
    final respone = await campRepo.getCampPreparingWorks(int.parse(campId));
    respone.when(
      success: (success) {
        prepare.addAll(success);
        emit(GetCampPreparingWorkSuccess());
      },
      failure: (error) {
        emit(GetCampPreparingWorkError(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetElectricalServices({required String campId}) async {
    CachHelper.getData(key: 'userType') == 'استشاري'
        ? null
        : await checkEditPermissionForCamp();
    prepare.clear();
    emit(GetCampPreparingWorkLoading());
    final respone = await campRepo.getElectricalServices(int.parse(campId), 0);
    respone.when(
      success: (success) {
        prepare.addAll(success);
        emit(GetCampPreparingWorkSuccess());
      },
      failure: (error) {
        emit(GetCampPreparingWorkError(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllCampDetails({required String campId}) async {
    await emitGetCampDetails(campId: campId);
    await emitGetCampPreparingWorks(campId: campId);
  }

  Future emitGetAllCampDetailsInMina({required String campId}) async {
    await emitGetCampDetails(campId: campId);
    await emitGetElectricalServices(campId: campId);
  }

  Future emitGetPreparing() async {
    await emitGetPreparingCampServices();
    await emitGetCampPreparingWorks(campId: '0');
  }

  Future emitGetBuilding() async {
    await emitGetPreparingCampServices();
    await emitGetCampBuildingWorks();
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
  List<File> files = [];
  String extention = '';
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

  Future emitPickFiles({required BuildContext context}) async {
    if (await askManageExternalStoragePermission(context: context)) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
          allowMultiple: true,
        );
        if (result != null) {
          files =
              result.files
                  .where((file) => file.path != null)
                  .map((file) => File(file.path!))
                  .toList();
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

  void clearImages(List<File> images, int index) {
    images.removeAt(index);
    emit(ClearAllDataState());
  }

  void clearFiles(List<File> files, int index) {
    files.removeAt(index);
    emit(ClearAllDataState());
  }

  void emitUpdateCampWork({
    required int id,
    required String? notes,
    double? rate,
    bool? fromMina,
    int? campId,
  }) async {
    emit(PostPreparingTentLoadingState());
    final response = await campRepo.updateCampWork(id, notes, image, rate);
    response.when(
      success: (success) async {
        if (fromMina != null) {
          await updateElectScore(id: campId!);
        }
        emit(PostPreparingTentSuccessState());
      },
      failure: (error) {
        emit(PostPreparingTentErrorState(error.failure.message ?? ''));
      },
    );
  }

  void emitUpdateItem({
    required int id,
    required String? notes,
    double? rate,
    bool? fromMina,
    int? campId,
  }) async {
    emit(PostPreparingTentLoadingState());
    final response = await campRepo.updateItem(id, notes, image, rate);
    response.when(
      success: (success) async {
        if (fromMina != null) {
          await updateElectScore(id: campId!);
        }
        emit(PostPreparingTentSuccessState());
      },
      failure: (error) {
        emit(PostPreparingTentErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future updateElectScore({required int id}) async {
    emit(UpdateScoreMinaLoadingState());
    final response = await campRepo.updateElectScore(id: id);
    response.when(
      success: (success) {
        emit(UpdateScoreMinaSuccessState());
      },
      failure: (error) {
        emit(UpdateScoreMinaErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetDropDownFilterResponse> filterList = [];
  Future emitGetDropDownFilter() async {
    emit(GetDropDownFilterLoadingState());
    final response = await campRepo.getDropDownFilter();
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

  List<GetCampAnalysisReponse> campAanalysis = [];
  Future emitGetCampPercentage({
    required int company,
    int? status,
    DateTime? modifiedDate,
  }) async {
    campAanalysis.clear();
    emit(GetCampPercentageLoadingState());
    final response = await campRepo.getCampPercentage(
      0,
      int.parse(zoneId == '' ? '0' : zoneId),
      status,
      modifiedDate,
    );
    response.when(
      success: (success) {
        campAanalysis.addAll(success);
        emit(GetCampPercentageSuccessState());
      },
      failure: (error) {
        emit(GetCampPercentageErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetCampAnalysisClassificationsResponse> classification = [];
  Future emitGetClassification({
    required int company,
    int? status,
    DateTime? modifiedDate,
  }) async {
    classification.clear();
    emit(GetCampPercentageLoadingState());
    final response = await campRepo.getClassification(
      0,
      int.parse(zoneId == '' ? '0' : zoneId),
      status,
      modifiedDate,
    );
    response.when(
      success: (success) {
        classification.addAll(success);
        emit(GetCampPercentageSuccessState());
      },
      failure: (error) {
        emit(GetCampPercentageErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetCampAnalysisTermsResponse> terms = [];
  Future emitGetTerms({
    required int company,
    int? status,
    DateTime? modifiedDate,
  }) async {
    terms.clear();
    emit(GetCampPercentageLoadingState());
    final response = await campRepo.getTerms(
      0,
      int.parse(zoneId == '' ? '0' : zoneId),
      status,
      modifiedDate,
    );
    response.when(
      success: (success) {
        terms.addAll(success);
        emit(GetCampPercentageSuccessState());
      },
      failure: (error) {
        emit(GetCampPercentageErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetZoneResponse> zones = [];
  String zoneId = '';
  Future emitGetDropDownZoneFilter() async {
    zones.clear();
    emit(GetZonesLoadingState());
    final response = await campRepo.getDropDownZoneFilter();
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

  void clearAllData() {
    campNumberController.clear();
    tentArea.clear();
    housingArea.clear();
    kitchenNumber.clear();
    numberOfCollectionToilets.clear();
    numberOfToilets.clear();
    numberOfHajjToilet.clear();
    squareId = '';
    markers.clear();
    companyId = null;
    zoneId = '';
    campNumbers.clear();
    image = null;
    files.clear();
    prepare.clear();

    emit(ClearAllDataState());
  }
}
