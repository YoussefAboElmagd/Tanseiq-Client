import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_option_types_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_status_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complain_types_analysis_response.dart';
import 'package:tanseiq/features/complains/data/models/get_complains_types.dart';
import 'package:tanseiq/features/complains/data/models/get_zone_response.dart';
import 'package:tanseiq/features/complains/data/repos/complains_repo.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';

class ComplainsCubit extends Cubit<ComplainsStates> {
  ComplainsCubit(this.complainsRepo) : super(ComplainsInitial());
  static ComplainsCubit get(context) => BlocProvider.of(context);
  final ComplainsRepo complainsRepo;

  TextEditingController escalationReason = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController responsablePresonName = TextEditingController();
  TextEditingController resonsablePresonPhone = TextEditingController();
  TextEditingController urlLocation = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Set<Marker> markers = {};
  GoogleMapController? googleController;

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void emitSelectLocation({required LatLng location}) {
    markers.clear();

    markers.add(Marker(markerId: const MarkerId('1'), position: location));
    googleController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 17),
      ),
    );
    emit(SelectLocationState());
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

  List<File> images = [];
  Future emitPickImage({required BuildContext context}) async {
    try {
      final source = await _showImageSourceDialog(context);
      if (source == null) {
        emit(UserCanceled());
        return;
      }

      List<XFile> result = [];
      if (source == ImageSource.camera) {
        final photo = await ImagePicker().pickImage(source: ImageSource.camera);
        if (photo != null) result = [photo];
      } else {
        result = await ImagePicker().pickMultiImage();
      }
      if (result.isNotEmpty) {
        images =
            result
                .map((xfile) => File(xfile.path))
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

  File? image;
  Future emitPickOneImage({required BuildContext context}) async {
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

  void clearFiles() {
    images.clear();
    image = null;
    emit(NoNewFilesAdded());
  }

  List<ComplainsData> complainsData = [];
  int page = 0;
  String problemStatusCode = '0';
  String problemTypeCode = '0';
  bool hasNext = true;
  Future emitGetAllProblems() async {
    hasNext = true;
    complainsData.clear();
    emit(GetAllComplainsLoadingState());
    final response = await complainsRepo.getAllProblems(
      problemType: int.parse(problemTypeCode),
      problemStatus: int.parse(problemStatusCode),
      page: page,
      pageSize: 10,
    );
    response.when(
      success: (data) {
        complainsData.addAll(data.complainsData);
        emit(GetAllComplainsSuccessState());
      },
      failure: (error) {
        emit(GetAllComplainsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllProblemsMethods() async {
    await emitGetProblemStatus();
    await emitGetComplainOptionTypes();
    await emitGetAllProblems();
  }

  Future emitGetPaginatedProblems() async {
    emit(GetPaginatedComplainsLoadingState());
    final response = await complainsRepo.getAllProblems(
      problemType: int.parse(problemTypeCode),
      page: page,
      pageSize: 10,
      problemStatus: int.parse(problemStatusCode),
    );
    int length = complainsData.length;
    response.when(
      success: (data) {
        page = data.currentPage;
        complainsData.addAll(data.complainsData);
        if (complainsData.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        emit(GetPaginatedComplainsSuccessState());
      },
      failure: (error) {
        emit(GetPaginatedComplainsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetAllProblemCadana() async {
    hasNext = true;
    complainsData.clear();
    emit(GetAllComplainsLoadingState());
    final response = await complainsRepo.getAllProblemCadana(
      page: page,
      pageSize: 10,
    );
    response.when(
      success: (data) {
        complainsData.addAll(data.complainsData);
        emit(GetAllComplainsSuccessState());
      },
      failure: (error) {
        emit(GetAllComplainsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetPaginatedProblemCadana() async {
    emit(GetPaginatedComplainsLoadingState());
    final response = await complainsRepo.getAllProblemCadana(
      page: page,
      pageSize: 10,
    );
    int length = complainsData.length;
    response.when(
      success: (data) {
        page = data.currentPage;
        complainsData.addAll(data.complainsData);
        if (complainsData.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        emit(GetPaginatedComplainsSuccessState());
      },
      failure: (error) {
        emit(GetPaginatedComplainsErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetAllCamps> campNumbers = [];
  String campNumber = '';
  String campNumberId = '';
  // Future emitGetAllCampNumber({
  //   required int zoneId,
  // }) async {
  //   campNumbers.clear();
  //   emit(GetAllCampNumberLoadingState());
  //   final response = await complainsRepo.getAllCampNumber(zoneId: zoneId);
  //   response.when(
  //     success: (data) {
  //       campNumbers.addAll(data);
  //       emit(GetAllCampNumberSuccessState());
  //     },
  //     failure: (error) {
  //       emit(GetAllCampNumberErrorState(error.failure.message ?? ''));
  //     },
  //   );
  // }
  Future getAllCamps() async {
    campNumbers.clear();
    emit(GetAllCampNumberLoadingState());
    final response = await complainsRepo.getAllCamps();
    response.when(
      success: (data) {
        campNumbers.addAll(data);
        emit(GetAllCampNumberSuccessState());
      },
      failure: (error) {
        emit(GetAllCampNumberErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitCheckPackage() async {
    emit(GetCheckLoadingState());
    final response = await complainsRepo.checkPackage(
      campId: int.parse(campNumberId),
      problemTypeCode: int.parse(complainTypeId),
    );
    response.when(
      success: (data) {
        if (data.isError) {
          emit(GetCheckErrorState(data.message ?? ''));
        } else {
          emit(GetCheckSuccessState());
        }
      },
      failure: (error) {},
    );
  }

  List<GetZoneResponse> zones = [];
  String zoneId = '';
  String zone = '';
  Future emitGetDropDownZoneFilter() async {
    campNumbers.clear();
    emit(GetZonesLoadingState());
    final response = await complainsRepo.getDropDownZoneFilter();
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

  List<GetComplainsTypes> types = [];
  String complainTypeId = '';
  String complainType = '';
  Future emitGetComplainsTypes() async {
    types.clear();
    emit(GetComplainTypeLoadingState());
    final response = await complainsRepo.getComplainsTypes();
    response.when(
      success: (data) {
        types.addAll(data);
        emit(GetComplainTypeSuccessState());
      },
      failure: (error) {
        emit(GetComplainTypeErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitAddComplainGetMethods() async {
    // await emitGetAllCampNumber(zoneId: 2);
    // await emitGetAllCampNumber(zoneId: 2);
    await getAllCamps();
    await emitGetComplainsTypes();
  }

  ComplainsData? complainsDataById;
  Future emitProblemById({required int id}) async {
    emit(GetProblemByIdLoadingState());
    final response = await complainsRepo.problemById(id: id);
    response.when(
      success: (data) {
        complainsDataById = data;
        emit(GetProblemByIdSuccessState());
      },
      failure: (error) {
        emit(GetProblemByIdErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitProblemCadanaById({required int id}) async {
    emit(GetProblemByIdLoadingState());
    final response = await complainsRepo.problemCadanaById(id: id);
    response.when(
      success: (data) {
        complainsDataById = data;
        emit(GetProblemByIdSuccessState());
      },
      failure: (error) {
        emit(GetProblemByIdErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitAddProblem() async {
    emit(AddComplainLoadingState());
    final response = await complainsRepo.addProblem(
      title: titleController.text,
      description: descriptionController.text,
      reporterName: responsablePresonName.text,
      phone: resonsablePresonPhone.text,
      date: DateTime.now().toString(),
      campId: int.parse(campNumberId),
      camp: campNumber,
      problemTypeCode: int.parse(complainTypeId),
      problemType: complainType,
      location: urlLocation.text,
      images: images,
    );
    response.when(
      success: (data) {
        emit(AddComplainSuccessState());
      },
      failure: (error) {
        emit(AddComplainErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitAddProblemCadana() async {
    emit(AddComplainLoadingState());
    final response = await complainsRepo.addProblemCadana(
      title: titleController.text,
      description: descriptionController.text,
      reporterName: 'MDARJ',
      phone: '123456789',
      date: DateTime.now().toString(),
      campId: int.parse(campNumberId),
      camp: campNumber,
      zoneId: int.parse(zoneId),
      zone: zone,
      problemTypeCode: int.parse(complainTypeId),
      problemType: complainType,
      location: markers.isEmpty ? null : markers.first.position.toString(),
      images: images,
    );
    response.when(
      success: (data) {
        emit(AddComplainSuccessState());
      },
      failure: (error) {
        emit(AddComplainErrorState(error.failure.message ?? ''));
      },
    );
  }

  String code = '';
  void emitGetCode({required int id}) async {
    emit(GetCodeLoadingState());
    final response = await complainsRepo.getProblemSolvedCode(id: id);
    response.when(
      success: (data) {
        code = data;
        codeController.text = data.substring(1, 9);
        emit(GetCodeSuccessState());
      },
      failure: (error) {
        emit(GetCodeErrorState(error.failure.message ?? ''));
      },
    );
  }

  void emitResolveProblem({required int id}) async {
    emit(ProblemSolvedLoadingState());
    final response = await complainsRepo.resolveProblem(
      id: id,
      code: codeController.text,
    );
    response.when(
      success: (data) {
        emit(ProblemSolvedSuccessState());
      },
      failure: (error) {
        emit(ProblemSolvedErrorState(error.failure.message ?? ''));
      },
    );
  }

  void emitUnSpecializedProblem({required int id}) async {
    emit(UnSpecializedProblemLoadingState());
    final response = await complainsRepo.unSpecializedProblem(
      id: id,
      code: codeController.text,
    );
    response.when(
      success: (data) {
        emit(UnSpecializedProblemSuccessState());
      },
      failure: (error) {
        emit(UnSpecializedProblemErrorState(error.failure.message ?? ''));
      },
    );
  }

  void emitSaveComment({required int id}) async {
    emit(SaveCommentLoadingState());
    final response = await complainsRepo.saveComment(
      id: id,
      content: escalationReason.text,
      image: image,
    );
    response.when(
      success: (data) {
        image = null;
        escalationReason.clear();
        emit(SaveCommentSuccessState());
      },
      failure: (error) {
        emit(SaveCommentErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetComplainOptionTypesResponse> problemStatus = [];
  Future emitGetProblemStatus() async {
    problemStatus.clear();
    emit(GetProblemStatusLoadingState());
    final response = await complainsRepo.getProblemStatus();
    response.when(
      success: (data) {
        problemStatus.add(GetComplainOptionTypesResponse(id: 0, name: 'الكل'));
        problemStatus.addAll(data);
        emit(GetProblemStatusSuccessState());
      },
      failure: (error) {
        emit(GetProblemStatusErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetComplainOptionTypesResponse> optionTypes = [];
  Future emitGetComplainOptionTypes() async {
    optionTypes.clear();
    emit(GetComplainOptionTypesLoadingState());
    final response = await complainsRepo.getComplainOptionTypes();
    response.when(
      success: (data) {
        optionTypes.add(GetComplainOptionTypesResponse(id: 0, name: 'الكل'));
        optionTypes.addAll(data);
        emit(GetComplainOptionTypesSuccessState());
      },
      failure: (error) {
        emit(GetComplainOptionTypesErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetComplainTypesAnalysisResponse> complainOptionTypes = [];
  Future emitGetComplainOtionTypesAnalysis() async {
    complainOptionTypes.clear();
    emit(GetComplainOtionTypesAnalysisLoadingState());
    final response = await complainsRepo.getProblemTypesGraph();
    response.when(
      success: (data) {
        complainOptionTypes.addAll(data);
        emit(GetComplainOtionTypesAnalysisSuccessState());
      },
      failure: (error) {
        emit(
          GetComplainOtionTypesAnalysisErrorState(error.failure.message ?? ''),
        );
      },
    );
  }

  List<GetComplainStatusAnalysisResponse> complainStatus = [];
  Future emitGetComplainStatusAnalysis() async {
    complainStatus.clear();
    emit(GetComplainStatusAnalysisLoadingState());
    final response = await complainsRepo.getProblemStatusGraph();
    response.when(
      success: (data) {
        complainStatus.addAll(data);
        emit(GetComplainStatusAnalysisSuccessState());
      },
      failure: (error) {
        emit(GetComplainStatusAnalysisErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitComplainAnalysisMethods() async {
    await emitGetComplainOtionTypesAnalysis();
    await emitGetComplainStatusAnalysis();
  }
}
