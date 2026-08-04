// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';

class DioFactory {
  // private constructor as i don't want to allow to make instances from this class
  DioFactory._();
  static Dio? dio;

  static Future<Dio> getDio() async {
    Duration timout = const Duration(seconds: 90);
    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timout
        ..options.receiveTimeout = timout;

      await addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  static Future addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await CachHelper.getData(key: 'token')}',
    };
  }

  static setTokenAfterLogin(String? token) async {
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }
}
