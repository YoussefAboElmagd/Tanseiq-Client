// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';

part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(ErrorHandler errorHandler) = Failure<T>;
}
