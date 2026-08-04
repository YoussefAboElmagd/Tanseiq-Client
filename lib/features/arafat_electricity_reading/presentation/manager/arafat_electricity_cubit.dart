import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/hijri_date_validator.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/arafat_electricity_reading/data/repos/arafat_electricity_repo.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_states.dart';
import 'package:tanseiq/features/recording_readings/data/models/get_generators_serials_response.dart';

class ArafatElectricityCubit extends Cubit<ArafatElectricityStates> {
  ArafatElectricityCubit(this._repo) : super(ArafatElectricityInitialState());
  final ArafatElectricityRepo _repo;
  static ArafatElectricityCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController rController = TextEditingController();
  final TextEditingController yController = TextEditingController();
  final TextEditingController bController = TextEditingController();

  List<GetGeneratorsSerialsResponse> generatorsList = [];
  String selectedGeneratorId = '';
  String selectedPeriod = _autoSelectPeriod();
  File? image;

  static String _autoSelectPeriod() {
    final hour = DateTime.now().hour;
    if (hour >= 8 && hour < 12) return 'period-1';
    if (hour >= 12 && hour < 16) return 'period-2';
    return 'period-3';
  }

  Future emitGetGeneratorsSerials() async {
    if (!HijriDateValidator.isAccessAllowed()) {
      emit(ArafatAccessRestrictedState());
      return;
    }
    generatorsList.clear();
    emit(GetGeneratorsSerialsLoadingState());
    final response = await _repo.getGeneratorsSerials();
    response.when(
      success: (data) {
        generatorsList.addAll(data);
        emit(GetGeneratorsSerialsSuccessState());
      },
      failure: (error) {
        emit(GetGeneratorsSerialsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitPickImage(BuildContext context) async {
    final granted = await _askStoragePermission(context);
    if (!granted) return;
    try {
      final source = await _showImageSourceDialog(context);
      if (source == null) {
        emit(ArafatUserCanceledState());
        return;
      }
      final XFile? result = await ImagePicker().pickImage(source: source);
      if (result != null) {
        image = File(result.path);
        emit(ArafatUserPickedFileState());
      } else {
        emit(ArafatUserCanceledState());
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      emit(ArafatUserCanceledState());
    }
  }

  Future emitSaveReading(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (selectedGeneratorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'يرجى اختيار رقم المحول',
          color: ColorsManager.darkRed,
        ),
      );
      return;
    }
    emit(SaveArafatReadingLoadingState());
    // ServiceCompany: use cached uid — update key if backend requires companyId
    final serviceCompanyId =
        CachHelper.getData(key: 'uid')?.toString() ?? '0';
    final response = await _repo.saveReading(
      generatorId: int.tryParse(selectedGeneratorId) ?? 0,
      r: double.tryParse(rController.text) ?? 0,
      y: double.tryParse(yController.text) ?? 0,
      b: double.tryParse(bController.text) ?? 0,
      serviceCompanyId: serviceCompanyId,
      image: image,
    );
    response.when(
      success: (data) {
        if (data is Map && data['isError'] == true) {
          emit(
            SaveArafatReadingErrorState(
              (data['message'] as String?) ?? 'حدث خطأ، يرجى المحاولة مجدداً',
            ),
          );
        } else {
          _clearForm();
          emit(SaveArafatReadingSuccessState());
        }
      },
      failure: (error) {
        emit(SaveArafatReadingErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) =>
      showModalBottomSheet<ImageSource>(
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

  Future<bool> _askStoragePermission(BuildContext? context) async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      status = info.version.sdkInt >= 33
          ? await Permission.photos.request()
          : await Permission.storage.request();
      if (status.isGranted || status.isLimited) return true;
    } else if (Platform.isIOS) {
      status = await Permission.photos.request();
      if (status.isGranted || status.isLimited) return true;
    } else {
      return false;
    }
    if (context != null && context.mounted) {
      final denied = Platform.isAndroid
          ? await Permission.storage.isPermanentlyDenied ||
              await Permission.photos.isPermanentlyDenied
          : await Permission.photos.isPermanentlyDenied;
      if (denied) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('صلاحية الوصول مطلوبة'),
            content: const Text(
              'يجب تفعيل صلاحية الوصول للصور من إعدادات التطبيق.',
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

  void _clearForm() {
    rController.clear();
    yController.clear();
    bController.clear();
    selectedGeneratorId = '';
    image = null;
    selectedPeriod = _autoSelectPeriod();
  }

  @override
  Future<void> close() {
    rController.dispose();
    yController.dispose();
    bController.dispose();
    return super.close();
  }
}
