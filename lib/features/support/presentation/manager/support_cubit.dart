import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanseiq/features/support/data/repos/support_repo.dart';
import 'package:tanseiq/features/support/presentation/manager/support_states.dart';

class SupportCubit extends Cubit<SupportStates> {
  SupportCubit(this.supportRepo) : super(SupportInitial());
  SupportRepo supportRepo;
  static SupportCubit get(context) => BlocProvider.of(context);

  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void deleteAttachment() {
    attachment = null;
    emit(NoNewFilesAdded());
  }

  Future emitAddSupportMessage({
    required String name,
    required String email,
    required BuildContext context,
  }) async {
    emit(UploadLoadingSupportState());
    final resposne = await supportRepo.addSupportMessage(
      name: name,
      email: email,
      message: messageController.text,
      attachment: attachment,
    );
    resposne.when(
      success: (data) {
        messageController.clear();
        attachment = null;
        emit(UploadSuccessSupportState());
      },
      failure: (error) {
        emit(UploadErrorSupportState(error.failure.message!));
      },
    );
  }
}
