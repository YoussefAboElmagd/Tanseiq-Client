import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_serials_response_pagination.dart';
import 'package:tanseiq/features/hypothesis/data/repos/hypothesis_repo.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_states.dart';

class HypothesisCubit extends Cubit<HypothesisStates> {
  HypothesisCubit(this.hypothesisRepo) : super(HypothesisInitial());
  static HypothesisCubit get(context) => BlocProvider.of(context);

  TextEditingController rController = TextEditingController();
  TextEditingController yController = TextEditingController();
  TextEditingController bController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final HypothesisRepo hypothesisRepo;

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

  int currentIndex = 1;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  int page = 0;
  bool hasNext = true;
  List<SerialsData> generatorsList = [];
  Future emitGetGeneratorsSerials() async {
    generatorsList.clear();
    emit(GetGeneratorsSerialsLoadingState());
    final response = await hypothesisRepo.getGeneratorsSerials(page);
    response.when(
      success: (success) {
        generatorsList.addAll(success.serialsData);
        emit(GetGeneratorsSerialsSuccessState());
      },
      failure: (error) {
        emit(GetGeneratorsSerialsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetPaginatedComplains() async {
    emit(GetGeneratorsSerialsPaginationLoadingState());
    final response = await hypothesisRepo.getGeneratorsSerials(page);
    int length = generatorsList.length;
    response.when(
      success: (data) {
        page = data.currentPage;
        generatorsList.addAll(data.serialsData);
        if (generatorsList.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        emit(GetGeneratorsSerialsPaginationSuccessState());
      },
      failure: (error) {
        emit(
          GetGeneratorsSerialsPaginationErrorState(error.failure.message ?? ''),
        );
      },
    );
  }

  List<GetGeneratorsReadingByTime> readingsList = [];
  Future emitGetReadingsView() async {
    emit(GetGeneratorsReadingLoadingState());
    final response = await hypothesisRepo.getReadingsView();
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

  Future emitSaveReading(BuildContext context, int id) async {
    emit(SaveReadingLoadingState());
    final response = await hypothesisRepo.saveReading(
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
        await emitGetGeneratorsSerials();
        emit(SaveReadingSuccessState());
      },
      failure: (error) {
        debugPrint(error.failure.message);
        emit(SaveReadingErrorState(error.failure.message ?? ''));
      },
    );
  }
}
