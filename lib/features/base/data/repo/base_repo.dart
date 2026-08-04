import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/networking/api_error_handler.dart';
import 'package:tanseiq/core/networking/api_result.dart';
import 'package:tanseiq/features/base/data/apis/base_api_services.dart';

class BaseRepo {
  final BaseApiServices baseApi;

  BaseRepo(this.baseApi);

  Future checkRoute({required String routeName}) async {
    try {
      final response = await baseApi.checkRoute(
        int.parse(CachHelper.getData(key: 'uid').toString()),
        routeName.split('/').last,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
