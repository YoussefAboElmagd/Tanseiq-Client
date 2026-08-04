import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/support/data/apis/support_api_services.dart';

class SupportRepo {
  final SupportApiServices supportApiServices;

  SupportRepo(this.supportApiServices);

  Future addSupportMessage({
    required String name,
    required String email,
    required String message,
    required File? attachment,
  }) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('Title', message));
      formData.fields.add(MapEntry('name', name));
      formData.fields.add(MapEntry('Email', email));
      formData.fields.add(MapEntry('Id', '0'));
      if (attachment != null && await attachment.exists()) {
        final bytes = await attachment.readAsBytes();
        formData.files.add(MapEntry(
          'AttcahmentFile',
          MultipartFile.fromBytes(bytes, filename: attachment.path.split('/').last),
        ));
      }
      final response = await supportApiServices.addSupportMessage(formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error.toString()));
    }
  }
}
